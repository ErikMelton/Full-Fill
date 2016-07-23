Person.create(name_first: 'Erik',
              name_middle: 'Allen',
              name_last: 'Melton',
              name_nick: 'Erik',
              name_prefix: 'Mr.',
              name_suffix: nil)

Person.create(name_first: 'Tristan',
              name_middle: 'Roger',
              name_last: 'Melton',
              name_nick: 'Tristan',
              name_prefix: 'Mr.',
              name_suffix: nil)

Facet.create(facettype: 'physical', facet_long: 'Physical', facet_desc: 'Physical activities')
Facet.create(facettype: 'expressive', facet_long: 'Expressive', facet_desc: 'Expressive activities')
Facet.create(facettype: 'creative', facet_long: 'Creative', facet_desc: 'Creative activities')
Facet.create(facettype: 'abstract', facet_long: 'Abstract', facet_desc: 'Abstraction based activities')
Facet.create(facettype: 'social', facet_long: 'Social', facet_desc: 'Social activities')