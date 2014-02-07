class Cite_Me 
  # Usage: 
  #    >> citation = Cite_Me.new
  #    >> source = { type: 'book',
  #               authors: ['Jacob Smith'],
  #                 title: 'The Art of Writing Code',
  #   city_of_publication: 'Indianapolis',
  #             publisher: 'Smith, Inc.',
  #   year_of_publication: '1992',
  #                medium: 'Print'}
  #    >> citation.generate_citation(source)
  #    => "Smith, Jacob. <i>The Art of Writing Code</i>. Indianapolis: Smith, Inc., 1992. Print."
  #
  # Options:
  #   Currently supported types are 'book', 'magazine', and 'web'
  #   All of these are in 'beta', but should work fine for generating regular citations

  def initialize()
  end

  def generate_citation(options)
    case options[:type]
    when 'book'
      mla_book_generate_citation(options)
    when 'magazine'
      mla_magazine_generate_citation(options)
    when 'web'
      mla_web_generate_citation(options)
    end
  end
  
  private

  def mla_book_generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  authors(clean_options[:authors])
   output <<  "<i>" + clean_options[:title] + "</i>. " if clean_options[:title]
   output <<  clean_options[:city_of_publication] + ": " if clean_options[:city_of_publication]
   output <<  clean_options[:publisher] + ", " if clean_options[:publisher]
   output <<  year_of_publication(clean_options[:year_of_publication])
   output <<  clean_options[:medium] + "." if clean_options[:medium]

   output
  end

  def mla_magazine_generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  authors(clean_options[:authors])
   output <<  %{"#{clean_options[:title_of_article]}." }
   output <<  "<i>" + clean_options[:title_of_periodical] + "</i> "
   output <<  clean_options[:publication_date] + ": "
   output <<  clean_options[:pages] + ". "
   output <<  clean_options[:medium] + "."

   output
  end
  
  def mla_web_generate_citation(options)
   clean_options = clean_hash(options)
   output = ''
   output <<  authors(clean_options[:authors]) || authors(clean_options[:author])
   output <<  "<i>" + clean_options[:name_of_site] + "</i>. "
  output << clean_options[:name_of_organization] + ", "
   output <<  clean_options[:date_of_creation] + ". "
   output <<  'Web. ' 
   output <<  clean_options[:date_of_access] + "."

   output
  end
  
  def authors(option)
    author_string = ''
    if option.is_a? String
      # if passed a string, cast it to an array 
      # then rename that array to option to be
      #consistent with the rest of the method
      author = []
      author << option
      option = author
    end

    option.each_with_index do |author, index|
      if author =~ /,/
        # Doe, John A.
        author_string += author
        author_string += index == option.length - 1 ? ". " : "and , "
      else
        # John Doe or John A. Doe
        name = author.split(" ")
        middle_initial = author.scan(/ \w\. /)
        author_string += name.last + ", " + name.first + middle_initial.first.to_s
        # add a period if it's the last entry and NOT a name with a middle initial
        author_string += index == option.length - 1 ? ". " : ", and " if middle_initial.empty?
      end
    end
    author_string
  end

  def year_of_publication(option)
    if option
      option.to_s + ". "
    else
      'n.d. '
    end
  end
  
  def clean_hash(options)
    clean_options = {}
    options.map do |key, value|
      if value == ''
        clean_options[key] = nil
      else
        clean_options[key] = value
      end
    end
    clean_options
  end

end
