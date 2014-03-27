require 'pry'
class Cite_Me 
  # Usage: 
  #    >> citation = Cite_Me.new
  #    >> source = { source_type: 'book',
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
   clean_options = clean_hash(options)
    case clean_options[:source_type]
    when 'book'
      mla_book_generate_citation(clean_options).strip
    when 'magazine'
      mla_magazine_generate_citation(clean_options).strip
    when 'web'
      mla_web_generate_citation(clean_options).strip
    end
  end
  
  private

  def mla_book_generate_citation(clean_options)
   output = ''
   output << author_info(clean_options)
   output <<  "<i>" + format_title(clean_options[:title]) + "</i>. " if clean_options[:title]
   output <<  clean_options[:city_of_publication] + ": " if clean_options[:city_of_publication]
   output <<  clean_options[:publisher] + ", " if clean_options[:publisher]
   output <<  year_of_publication(clean_options[:year_of_publication])
   output <<  clean_options[:medium] + "." if clean_options[:medium]

   output
  end

  def mla_magazine_generate_citation(clean_options)
   output = ''
   output << author_info(clean_options) 
   output <<  %{"#{format_title clean_options[:title_of_article]}." } if clean_options[:title_of_article]
   output <<  "<i>" + clean_options[:title_of_periodical] + "</i> " if clean_options[:title_of_periodical]
   output <<  clean_options[:publication_date] + ": " if clean_options[:publication_date]
   output <<  clean_options[:pages] + ". " if clean_options[:pages]
   output <<  clean_options[:medium] + "." if clean_options[:medium]

   output
  end
  
  def mla_web_generate_citation(clean_options)
   output = ''
   output << author_info(clean_options)
   output <<  "<i>" + clean_options[:name_of_site] + "</i>. " if clean_options[:name_of_site]
   output << clean_options[:name_of_organization] + ", " if clean_options[:name_of_organization]
   output <<  clean_options[:date_of_creation] + ". " if clean_options[:date_of_creation]
   output <<  'Web. ' 
   output <<  clean_options[:date_of_access] + "." if clean_options[:date_of_access]

   output
  end
 
  def format_title(title)
    # If the entry ends in '?', '!', or '.', do not add a '.' to the end
    %w[? ! .].include?(title[-1]) ? title[0..(title.length-2)] : title
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
        # option.length - 1 checks if last entry in array of authors
        #   if so, end with period, else, 'and , '
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

  def author_info(clean_options)
    if clean_options[:authors]
      authors(clean_options[:authors])
    elsif clean_options[:author]
      authors(clean_options[:author])
    else
      # return empty string so it can concat it without error
      ''
    end
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
    if options.class.ancestors.to_s.include?('ActiveRecord::Base')
      options = options.attributes
    end

    ## delete any " in key (usually from ActiveRecord object) and turn it to a symbol
    ## we also call to_s on any present values in case a date or year is saved
    ## as an integer in the database
    options.map do |key, value|
      if value == ''
        cleaned_key = ( key.is_a? Symbol ) ? key : key.delete('"').to_sym
        clean_options[cleaned_key] = nil
      else
        cleaned_key = ( key.is_a? Symbol ) ? key : key.delete('"').to_sym
        clean_options[cleaned_key] = value
      end
    end
    clean_options
  end

end
