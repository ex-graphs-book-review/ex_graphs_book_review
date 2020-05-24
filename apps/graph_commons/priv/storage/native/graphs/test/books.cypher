CREATE
(book:Book {
    iri: "urn:isbn:978-1-68050-252-7",
    date: "2018-03-14",
    format: "Paper",
    title: "Adopting Elixir"
}),
(author1:Author { iri: "https://twitter.com/bgmarx", name: "Ben Marx" }),
(author2:Author { iri: "https://twitter.com/josevalim", name: "José Valim" }),
(author3:Author { iri: "https://twitter.com/redrapids", name: "Bruce Tate" }),
(publisher:Publisher { iri: "https://pragprog.com/", name: "The Pragmatic Bookshelf" })

CREATE
(book)-[:AUTHORED_BY { role: "first author" }]->(author1),
(book)-[:AUTHORED_BY { role: "second author" }]->(author2),
(book)-[:AUTHORED_BY { role: "third author" }]->(author3),
(book)-[:PUBLISHED_BY]->(publisher)

;
