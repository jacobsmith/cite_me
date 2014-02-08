Cite-Me
======
[![Gem Version](https://badge.fury.io/rb/cite-me.png)](http://badge.fury.io/rb/cite-me)

Create properly formatted MLA citations, suitable for use in a bibliography, works cited, etc.


Usage
=====
Add 'cite-me' to your Gemfile or `gem install cite-me`

In your code, create a new instance of Cite_Me `cite = Cite_Me.new`

You can now build a hash of options to pass to it:

       options = { source_type: 'book',
                authors: ['Smith, Jacob'],
                  title: 'The Art of Writing Code',
    city_of_publication: '',
              publisher: 'Smith, Inc.',
    year_of_publication: '',
                 medium: 'Print'}

Now, simply call `cite.generate_citation(options)` and it will return a propery formatted MLA citation.

You can also pass in an ActiveRecord Object's #attributes and it will return a proper citation. Example:
      source = Source.first
      c = Cite_Me.new
      c.generate_citation source.attributes

Please note that the columns on the passed object must match up with those in the hashes on this page (title, city_of_publication, etc.).

Possible for source_type currently include:
`book`
`magazine`
`web`

Each of these accepts options that make sense for that specific source_type of medium:

Book

        options = { source_type: 'book',
                 authors: ['Smith, Jacob'],
                   title: 'The Art of Writing Code',
     city_of_publication: '',
               publisher: 'Smith, Inc.',
     year_of_publication: '',
                  medium: 'Print'}

Magazine

        options = { source_type: 'magazine',
                 authors: ['Jacob Smith'],
        title_of_article: 'Fishing redefined',
     title_of_periodical: 'Fishes-R-Us',
        publication_date: '10 October 1992',
                   pages: '1-4',
                  medium: 'Print'} `

Web

         options = { source_type: 'web',
                  authors: 'John A. Doe',
             name_of_site: 'Starbucks',
     name_of_organization: 'Time',
         date_of_creation: '10 Oct 1992',
           date_of_access: '14 Feb 2014' }

Notes
=====
You may either pass a string to :author or an array of strings to :authors

It will properly detect if it is already in Last Name, First Name order and not rearrange them. It also has support for middle initials being used.

