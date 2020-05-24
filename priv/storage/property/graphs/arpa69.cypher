// ####
// # ARPANET - Dec 1969 [1]
// #
// # [1] https://www.scientificamerican.com/gallery/early-sketch-of-arpanets-first-four-nodes/
// ####


//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)


// Site: UCLA

CREATE (ucla:Node { id: "ucla", type: "IMP", name: "UCLA" })
CREATE (ucla_h1:Host { id: "ucla_h1", name: "SIGMA7" })
CREATE (ucla_h1)-[:H_LINK]->(ucla)


// Site: UCSB

CREATE (ucsb:Node { id: "ucsb", type: "IMP", name: "UCSB" })
CREATE (ucsb_h1:Host { id: "ucsb_h1", name: "360" })
CREATE (ucsb_h1)-[:H_LINK]->(ucsb)


// Site: SRI

CREATE (sri:Node { id: "sri", type: "IMP", name: "SRI" })
CREATE (sri_h1:Host { id: "sri_h1", name: "940" })
CREATE (sri_h1)-[:H_LINK]->(sri)


//
// SEGMENT 2 - Outer Path (Right from SRI to UTAH)


// Site: UTAH

CREATE (utah:Node { id: "utah", type: "IMP", name: "UTAH" })
CREATE (utah_h1:Host { id: "utah_h1", name: "PDP-10" })
CREATE (utah_h1)-[:H_LINK]->(utah)


// NETWORK (3+1=4)

//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SRI)
CREATE (ucla)-[:N_LINK]->(ucsb)
CREATE (ucsb)-[:N_LINK]->(sri)
CREATE (sri)-[:N_LINK]->(ucla)
//
// SEGMENT 2 - Outer Path (Right from SRI to UTAH)
CREATE (sri)-[:N_LINK]->(utah)
