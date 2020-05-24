// book 1
CREATE
(bk1:Book {
    id:  "adopting_elixir",
    iri: "urn:isbn:978-1-68050-252-7",
    date: "2018-03-14",
    format: "Paper",
    title: "Adopting Elixir"
}),
(bk1_au1:Author {
    id: "ben_marx",
    iri: "https://twitter.com/bgmarx",
    name: "Ben Marx"
}),
(bk1_au2:Author {
    id: "jose_valim",
    iri: "https://twitter.com/josevalim",
    name: "José Valim"
}),
(bk1_au3:Author {
    id: "bruce_tate",
    iri: "https://twitter.com/redrapids",
    name: "Bruce Tate"
}),
(bk1_pub:Publisher {
    id: "pragmatic",
    iri: "https://pragprog.com/",
    name: "The Pragmatic Bookshelf"
})

CREATE
(bk1)-[:AUTHOR { role: "first author" }]->(bk1_au1),
(bk1)-[:AUTHOR { role: "second author" }]->(bk1_au2),
(bk1)-[:AUTHOR { role: "third author" }]->(bk1_au3),
(bk1)-[:PUBLISHER]->(bk1_pub),
(bk1_pub)-[:BOOK]->(bk1)


// book 2
CREATE
(bk2:Book {
    id:  "graphql_apis",
    iri: "urn:isbn:978-1-68050-255-8",
    date: "2018-03-27",
    format: "Paper",
    title: "Craft GraphQL APIs in Elixir with Absinthe"
}),
(bk2_au1:Author {
    id: "bruce_williams",
    iri: "https://twitter.com/wbruce",
    name: "Bruce Williams"
}),
(bk2_au2:Author {
    id: "ben_wilson",
    iri: "https://twitter.com/benwilson512",
    name: "Ben Wilson"
}),
(bk2_pub:Publisher {
    id: "pragmatic",
    iri: "https://pragprog.com/",
    name: "The Pragmatic Bookshelf"
})

CREATE
(bk2)-[:AUTHOR { role: "first author" }]->(bk2_au1),
(bk2)-[:AUTHOR { role: "second author" }]->(bk2_au2),
(bk2)-[:PUBLISHER]->(bk2_pub),
(bk2_pub)-[:BOOK]->(bk2)


// book 3
CREATE
(bk3:Book {
    id:  "designing_elixir",
    iri: "urn:isbn:978-1-68050-661-7",
    date: "2019-11-20",
    format: "Paper",
    title: "Designing Elixir Systems with OTP"
}),
(bk3_au1:Author {
    id: "james_gray",
    iri: "https://twitter.com/JEG2",
    name: "James Edward Gray II"
}),
(bk3_au2:Author {
    id: "bruce_tate",
    iri: "https://twitter.com/redrapids",
    name: "Bruce Tate"
}),
(bk3_pub:Publisher {
    id: "pragmatic",
    iri: "https://pragprog.com/",
    name: "The Pragmatic Bookshelf"
})

CREATE
(bk3)-[:AUTHOR { role: "first author" }]->(bk3_au1),
(bk3)-[:AUTHOR { role: "second author" }]->(bk3_au2),
(bk3)-[:PUBLISHER]->(bk3_pub),
(bk3_pub)-[:BOOK]->(bk3)


// book 4
CREATE
(bk4:Book {
    id:  "graph_algorithms",
    iri: "urn:isbn:978-1-492-04767-4",
    date: "2019-03-16",
    format: "Paper",
    title: "Graph Algorithms"
}),
(bk4_au1:Author {
    id: "amy_hodler",
    iri: "https://twitter.com/amyhodler",
    name: "Amy E. Hodler"
}),
(bk4_au2:Author {
    id: "mark_needham",
    iri: "https://twitter.com/markhneedham",
    name: "Mark Needham"
}),
(bk4_pub:Publisher {
    id: "oreilly",
    iri: "https://www.oreilly.com/",
    name: "O'Reilly Media"
})

CREATE
(bk4)-[:AUTHOR { role: "first author" }]->(bk4_au1),
(bk4)-[:AUTHOR { role: "second author" }]->(bk4_au2),
(bk4)-[:PUBLISHER]->(bk4_pub),
(bk4_pub)-[:BOOK]->(bk4)

;
