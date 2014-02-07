require 'spec_helper'

describe Cite_Me do
  let!(:mla) { Cite_Me.new }

  describe 'returns proper book citation' do
    options = { type: 'book',
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
    options = { type: 'book',
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
    options = { type: 'magazine',
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
    options = { type: 'web',
      authors: ['John A. Doe'],
      name_of_site: 'Starbucks',
      name_of_organization: 'Time',
      date_of_creation: '10 Oct 1992',
      date_of_access: '14 Feb 2014' }
    it 'with full good input' do
      expect(mla.generate_citation(options)).to eq 'Doe, John A. <i>Starbucks</i>. Time, 10 Oct 1992. Web. 14 Feb 2014.'
    end
  end
end
