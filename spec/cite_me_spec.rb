require 'spec_helper'

describe Cite_Me do
  let!(:mla) { Cite_Me.new }

  describe 'returns proper book citation' do
    options = { source_type: 'book',
      authors: ['Jacob Smith'], 
      title: 'The Art of Writing Code',
      city_of_publication: 'Indianapolis',
      publisher: 'Smith, Inc.',
      year_of_publication: '1992',
      medium: 'Print'}

    it 'with good input' do
      expect(mla.generate_citation(options)).to eq "Smith, Jacob. <i>The Art of Writing Code</i>. Indianapolis: Smith, Inc., 1992. Print."
    end
  end

  describe 'returns proper book citation' do
    options = { source_type: 'book',
      authors: ['Smith, Jacob'], 
      title: 'The Art of Writing Code',
      city_of_publication: '',
      publisher: 'Smith, Inc.',
      year_of_publication: '',
      medium: 'Print'}
    it 'when missing inputs' do
      expect(mla.generate_citation(options)).to eq "Smith, Jacob. <i>The Art of Writing Code</i>. Smith, Inc., n.d. Print."
    end
  end

  describe 'returns proper magazine citation' do
    options = { source_type: 'magazine',
      authors: ['Jacob Smith'],
      title_of_article: 'Fishing redefined',
      title_of_periodical: 'Fishes-R-Us',
      publication_date: '10 October 1992',
      pages: '1-4',
      medium: 'Print'}
    it 'with full good input' do
      expect(mla.generate_citation(options)).to eq 'Smith, Jacob. "Fishing redefined." <i>Fishes-R-Us</i> 10 October 1992: 1-4. Print.'
    end
  end

  describe 'returns proper web citation' do
    options = { source_type: 'web',
      authors: ['John A. Doe'],
      name_of_site: 'Starbucks',
      name_of_organization: 'Time',
      date_of_creation: '10 Oct 1992',
      date_of_access: '14 Feb 2014' }
    it 'with full good input' do
      expect(mla.generate_citation(options)).to eq 'Doe, John A. <i>Starbucks</i>. Time, 10 Oct 1992. Web. 14 Feb 2014.'
    end
  end

  describe 'propertly handles author/authors and string vs. array inputs' do
    options = { source_type: 'web',
      author: 'John A. Doe',
      name_of_site: 'Starbucks',
      name_of_organization: 'Time',
      date_of_creation: '10 Oct 1992',
      date_of_access: '14 Feb 2014' }
    it 'assumes options[:author] is one author and will accept string' do
      expect(mla.generate_citation(options)).to eq 'Doe, John A. <i>Starbucks</i>. Time, 10 Oct 1992. Web. 14 Feb 2014.'
    end
  end

    it 'assumes options[:authors] is multiple authors and will accept array' do
      expect(mla.send(:authors,['Jacob Smith', 'John A. Doe'])).to eq 'Smith, Jacob, and Doe, John A. '
    end

  describe 'when given an ActiveRecord object by passing object.attributes as input' do
      options = {"id"=>1,
        "title"=>"Test Source One",
        "author"=>"",
        "url"=>"URL",
        "comments"=>"Comments (:\r\n",
        "created_at"=>"Thu, 23 Jan 2014 02:10:10 UTC +00:00",
        "updated_at"=>"Sat, 08 Feb 2014 19:07:42 UTC +00:00",
        "authors"=>"Jacob Smith",
        "city_of_publication"=>nil,
        "year_of_publication"=>1992,
        "publisher"=>nil,
        "medium"=>'Print',
        "source_type"=>"book"}
    it 'returns the proper citation' do
      expect(mla.generate_citation(options)).to eq "Smith, Jacob. <i>Test Source One</i>. 1992. Print."
    end
  end

  describe 'when given just a title' do
    options = { source_type: 'book', title: 'This is a title'}
    it 'should still return a title properly formatted' do
      expect(mla.generate_citation(options)).to eq '<i>This is a title</i>. n.d.'
    end
  end
end
