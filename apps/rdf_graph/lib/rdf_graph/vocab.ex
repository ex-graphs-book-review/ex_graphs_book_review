defmodule RDFGraph.Vocab do
  @moduledoc """
  Module for exploring RDF.Vocabulary.Namespace
  """

  use RDF.Vocabulary.Namespace

  alias RDF.NS.XSD

  defvocab(DC,
    base_iri: "http://purl.org/dc/elements/1.1/",
    file: "dc.ttl"
    # terms: ~w[
    #   contributor coverage creator date description format
    #   identifier language publisher relation rights source
    #   subject title type
    # ]
  )

  defvocab(BIBO,
    base_iri: "http://purl.org/ontology/bibo/",
    file: "bibo.ttl",
    case_violations: :ignore
  )

  defvocab(DCTERMS,
    base_iri: "http://purl.org/dc/terms/",
    file: "bibo.ttl",
    case_violations: :ignore
  )

  defvocab(EVENT,
    base_iri: "http://purl.org/NET/c4dm/event.owl#",
    file: "bibo.ttl"
  )

  defvocab(FOAF,
    base_iri: "http://xmlns.com/foaf/0.1/",
    file: "bibo.ttl"
  )

  defvocab(PRISM,
    base_iri: "http://prismstandard.org/namespaces/1.2/basic/",
    file: "bibo.ttl"
  )

  defvocab(SCHEMA,
    base_iri: "http://schemas.talis.com/2005/address/schema#",
    file: "bibo.ttl"
  )

  defvocab(STATUS,
    base_iri: "http://purl.org/ontology/bibo/status/",
    file: "bibo.ttl",
    case_violations: :ignore
  )

  ## book function defintions

  def book() do

    import RDF.Sigils
    alias RDF.NS.{XSD}

    ~I<urn:isbn:978-1-68050-252-7>
    |> RDF.type(BIBO.Book)
    |> DC.creator(
      ~I<https://twitter.com/bgmarx>,
      ~I<https://twitter.com/josevalim>,
      ~I<https://twitter.com/redrapids>
    )
    |> DC.date(RDF.date("2018-03-14"))
    |> DC.format(~L"Paper")
    |> DC.identifier(~L"adopting_elixir")
    |> DC.identifier(RDF.literal("urn:isbn:978-1-68050-252-7",
        datatype: XSD.anyURI()))
    |> DC.publisher(~I<https://pragprog.com/>)
    |> DC.title(~L"Adopting Elixir"en)
  end

  def book_long() do

    alias RDF.NS.{XSD}

    s = RDF.iri("urn:isbn:978-1-68050-252-7")

    t0 = {s, RDF.type(), RDF.iri(BIBO.Book)}
    t1 = {s, DC.creator(), RDF.iri("https://twitter.com/bgmarx")}
    t2 = {s, DC.creator(), RDF.iri("https://twitter.com/josevalim")}
    t3 = {s, DC.creator(), RDF.iri("https://twitter.com/redrapids")}
    t4 = {s, DC.date(), RDF.literal("2018-03-14", datatype: XSD.date())}
    t5 = {s, DC.format(), RDF.literal("Paper")}
    t6 = {s, DC.identifier(), RDF.literal("adopting_elixir")}
    t7 = {s, DC.identifier(), RDF.literal("urn:isbn:978-1-68050-252-7", datatype: XSD.anyURI())}
    t8 = {s, DC.publisher(), RDF.iri("https://pragprog.com/")}
    t9 = {s, DC.title(), RDF.literal("Adopting Elixir", language: "en")}

    RDF.Description.new([t0, t1, t2, t3, t4, t5, t6, t7, t8, t9])
  end

end
