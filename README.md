Cite-Me
======

Create properly formatted MLA citations, suitable for use in a bibliography, works cited, etc.


Usage
=====
Add 'cite-me' to your Gemfile or `gem install cite-me`

In your code, create a new instance of Cite_Me `cite = Cite_Me.new`

You can now build a hash of options to pass to it:

       options = { type: 'book',
                authors: ['Smith, Jacob'],
                  title: 'The Art of Writing Code',
    city_of_publication: '',
              publisher: 'Smith, Inc.',
    year_of_publication: '',
                 medium: 'Print'}

Now, simply call `cite.generate_citation(options)` and it will return a propery formatted MLA citation.

Possible for type currently include:
`book`
`magazine`
`web`

Each of these accepts options that make sense for that specific type of medium:

Book
       options = { type: 'book',
                authors: ['Smith, Jacob'],
                  title: 'The Art of Writing Code',
    city_of_publication: '',
              publisher: 'Smith, Inc.',
    year_of_publication: '',
                 medium: 'Print'}

Magazine
       options = { type: 'magazine',
                authors: ['Jacob Smith'],
       title_of_article: 'Fishing redefined',
    title_of_periodical: 'Fishes-R-Us',
       publication_date: '10 October 1992',
                  pages: '1-4',
                 medium: 'Print'} `

Web
        options = { type: 'web',
                 authors: 'John A. Doe',
            name_of_site: 'Starbucks',
    name_of_organization: 'Time',
        date_of_creation: '10 Oct 1992',
          date_of_access: '14 Feb 2014' }

Notes
=====
You may either pass a string to :author or an array of strings to :authors

It will properly detect if it is already in Last Name, First Name order and not rearrange them. It also has support for middle initials being used.

