// ####
// # ARPANET - Dec 1970 [1]
// #
// # [1] http://mercury.lcs.mit.edu/~jnc/tech/arpalog.html
// ####


//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)


// Site: UCLA

CREATE (ucla:Node { id: "ucla", type: "IMP", name: "UCLA" })
CREATE (ucla_h1:Host { id: "ucla_h1", name: "360/91" })
CREATE (ucla_h2:Host { id: "ucla_h2", name: "XDS SIGMA7" })
CREATE (ucla_h1)-[:H_LINK]->(ucla)
CREATE (ucla_h2)-[:H_LINK]->(ucla)


// Site: SRI

CREATE (sri:Node { id: "sri", type: "IMP", name: "SRI" })
CREATE (sri_h1:Host { id: "sri_h1", name: "PDP-10" })
CREATE (sri_h2:Host { id: "sri_h2", name: "XDS-940" })
CREATE (sri_h1)-[:H_LINK]->(sri)
CREATE (sri_h2)-[:H_LINK]->(sri)


// Site: UTAH

CREATE (utah:Node { id: "utah", type: "IMP", name: "UTAH" })
CREATE (utah_h1:Host { id: "utah_h1", name: "PDP-10" })
CREATE (utah_h1)-[:H_LINK]->(utah)


// Site: MIT

CREATE (mit:Node { id: "mit", type: "IMP", name: "MIT" })
CREATE (mit_h1:Host { id: "mit_h1", name: "PDP-10" })
CREATE (mit_h2:Host { id: "mit_h2", name: "PDP-10" })
CREATE (mit_h3:Host { id: "mit_h3", name: "GE-645" })
CREATE (mit_h1)-[:H_LINK]->(mit)
CREATE (mit_h2)-[:H_LINK]->(mit)
CREATE (mit_h3)-[:H_LINK]->(mit)


// Site: LINCOLN

CREATE (lincoln:Node { id: "lincoln", type: "IMP", name: "LINCOLN" })
CREATE (lincoln_h1:Host { id: "lincoln_h1", name: "360/67" })
CREATE (lincoln_h2:Host { id: "lincoln_h2", name: "TX2" })
CREATE (lincoln_h3:Host { id: "lincoln_h3", name: "TSP" })
CREATE (lincoln_h1)-[:H_LINK]->(lincoln)
CREATE (lincoln_h2)-[:H_LINK]->(lincoln)
CREATE (lincoln_h3)-[:H_LINK]->(lincoln)


// Site: CASE

CREATE (case:Node { id: "case", type: "IMP", name: "CASE" })
CREATE (case_h1:Host { id: "case_h1", name: "PDP-10" })
CREATE (case_h1)-[:H_LINK]->(case)


// Site: CARNEGIE

CREATE (carnegie:Node { id: "carnegie", type: "IMP", name: "CARNEGIE" })
CREATE (carnegie_h1:Host { id: "carnegie_h1", name: "PDP-10" })
CREATE (carnegie_h1)-[:H_LINK]->(carnegie)


// Site: HARVARD

CREATE (harvard:Node { id: "harvard", type: "IMP", name: "HARVARD" })
CREATE (harvard_h1:Host { id: "harvard_h1", name: "PDP-1" })
CREATE (harvard_h2:Host { id: "harvard_h2", name: "PDP-10" })
CREATE (harvard_h1)-[:H_LINK]->(harvard)
CREATE (harvard_h2)-[:H_LINK]->(harvard)


// Site: BBN

CREATE (bbn:Node { id: "bbn", type: "IMP", name: "BBN" })
CREATE (bbn_h1:Host { id: "bbn_h1", name: "DDP-516" })
CREATE (bbn_h2:Host { id: "bbn_h2", name: "PDP-10" })
CREATE (bbn_h1)-[:H_LINK]->(bbn)
CREATE (bbn_h2)-[:H_LINK]->(bbn)


// Site: RAND

CREATE (rand:Node { id: "rand", type: "IMP", name: "RAND" })
CREATE (rand_h1:Host { id: "rand_h1", name: "IBM 1800" })
CREATE (rand_h2:Host { id: "rand_h2", name: "360/65" })
CREATE (rand_h1)-[:H_LINK]->(rand)
CREATE (rand_h2)-[:H_LINK]->(rand)


//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)


// Site: UCSB

CREATE (ucsb:Node { id: "ucsb", type: "IMP", name: "UCSB" })
CREATE (ucsb_h1:Host { id: "ucsb_h1", name: "360/75" })
CREATE (ucsb_h1)-[:H_LINK]->(ucsb)


//
// SEGMENT 3 - Inner Path (Up from RAND to SRI)


// Site: STANFORD

CREATE (stanford:Node { id: "stanford", type: "IMP", name: "STANFORD" })
CREATE (stanford_h1:Host { id: "stanford_h1", name: "PDP-10" })
CREATE (stanford_h1)-[:H_LINK]->(stanford)


//
// SEGMENT 4 - Inner Path (Up from RAND to UTAH)


// Site: SDC

CREATE (sdc:Node { id: "sdc", type: "IMP", name: "SDC" })
CREATE (sdc_h1:Host { id: "sdc_h1", name: "DDP-516" })
CREATE (sdc_h2:Host { id: "sdc_h2", name: "360/67" })
CREATE (sdc_h1)-[:H_LINK]->(sdc)
CREATE (sdc_h2)-[:H_LINK]->(sdc)


//
// SEGMENT 5 - Inner Path (Up from BBN to MIT)


// NETWORK (10+2+2+2+1=17)

//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)
CREATE (ucla)-[:N_LINK]->(sri)
CREATE (sri)-[:N_LINK]->(utah)
CREATE (utah)-[:N_LINK]->(mit)
CREATE (mit)-[:N_LINK]->(lincoln)
CREATE (lincoln)-[:N_LINK]->(case)
CREATE (case)-[:N_LINK]->(carnegie)
CREATE (carnegie)-[:N_LINK]->(harvard)
CREATE (harvard)-[:N_LINK]->(bbn)
CREATE (bbn)-[:N_LINK]->(rand)
CREATE (rand)-[:N_LINK]->(ucla)
//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)
CREATE (ucla)-[:N_LINK]->(ucsb)
CREATE (ucsb)-[:N_LINK]->(sri)
//
// SEGMENT 3 - Inner Path (Up from RAND to SRI)
CREATE (rand)-[:N_LINK]->(stanford)
CREATE (stanford)-[:N_LINK]->(sri)
//
// SEGMENT 4 - Inner Path (Up from RAND to UTAH)
CREATE (rand)-[:N_LINK]->(sdc)
CREATE (sdc)-[:N_LINK]->(utah)
//
// SEGMENT 5 - Inner Path (Up from BBN to MIT)
CREATE (bbn)-[:N_LINK]->(mit)
