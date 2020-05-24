


CREATE (stanford:Host { id: "stanford", gateway: "IMP", site: "STANFORD" })

CREATE (stanford_h1:Host { id: "stanford_h1", computer: "PDP-10" })




CREATE (stanford_h1)-[:LINK]->(stanford)



CREATE (sri:Host { id: "sri", gateway: "IMP", site: "SRI" })

CREATE (sri_h1:Host { id: "sri_h1", computer: "PDP-10" })
CREATE (sri_h2:Host { id: "sri_h2", computer: "XDS-940" })





CREATE (sri_h1)-[:LINK]->(sri)
CREATE (sri_h2)-[:LINK]->(sri)



CREATE (utah:Host { id: "utah", gateway: "IMP", site: "UTAH" })

CREATE (utah_h1:Host { id: "utah_h1", computer: "PDP-10" })




CREATE (utah_h1)-[:LINK]->(utah)



CREATE (mit:Host { id: "mit", gateway: "IMP", site: "MIT" })

CREATE (mit_h1:Host { id: "mit_h1", computer: "PDP-10" })
CREATE (mit_h2:Host { id: "mit_h2", computer: "PDP-10" })
CREATE (mit_h3:Host { id: "mit_h3", computer: "GE-645" })






CREATE (mit_h1)-[:LINK]->(mit)
CREATE (mit_h2)-[:LINK]->(mit)
CREATE (mit_h3)-[:LINK]->(mit)



CREATE (bbn:Host { id: "bbn", gateway: "IMP", site: "BBN" })

CREATE (bbn_h1:Host { id: "bbn_h1", computer: "DDP-516" })
CREATE (bbn_h2:Host { id: "bbn_h2", computer: "PDP-10" })





CREATE (bbn_h1)-[:LINK]->(bbn)
CREATE (bbn_h2)-[:LINK]->(bbn)



CREATE (harvard:Host { id: "harvard", gateway: "IMP", site: "HARVARD" })

CREATE (harvard_h1:Host { id: "harvard_h1", computer: "PDP-1" })
CREATE (harvard_h2:Host { id: "harvard_h2", computer: "PDP-10" })





CREATE (harvard_h1)-[:LINK]->(harvard)
CREATE (harvard_h2)-[:LINK]->(harvard)




CREATE (rand:Host { id: "rand", gateway: "IMP", site: "RAND" })

CREATE (rand_h1:Host { id: "rand_h1", computer: "IBM 1800" })
CREATE (rand_h2:Host { id: "rand_h2", computer: "360/65" })





CREATE (rand_h1)-[:LINK]->(rand)
CREATE (rand_h2)-[:LINK]->(rand)



CREATE (ucla:Host { id: "ucla", gateway: "IMP", site: "UCLA" })

CREATE (ucla_h1:Host { id: "ucla_h1", computer: "360/91" })
CREATE (ucla_h2:Host { id: "ucla_h2", computer: "XDS SIGMA7" })





CREATE (ucla_h1)-[:LINK]->(ucla)
CREATE (ucla_h2)-[:LINK]->(ucla)



CREATE (sdc:Host { id: "sdc", gateway: "IMP", site: "SDC" })

CREATE (sdc_h1:Host { id: "sdc_h1", computer: "DDP-516" })
CREATE (sdc_h2:Host { id: "sdc_h2", computer: "360/67" })





CREATE (sdc_h1)-[:LINK]->(sdc)
CREATE (sdc_h2)-[:LINK]->(sdc)



CREATE (case:Host { id: "case", gateway: "IMP", site: "CASE" })

CREATE (case_h1:Host { id: "case_h1", computer: "PDP-10" })




CREATE (case_h1)-[:LINK]->(case)



CREATE (lincoln:Host { id: "lincoln", gateway: "IMP", site: "LINCOLN" })

CREATE (lincoln_h1:Host { id: "lincoln_h1", computer: "360/67" })
CREATE (lincoln_h2:Host { id: "lincoln_h2", computer: "TX2" })
CREATE (lincoln_h3:Host { id: "lincoln_h3", computer: "TSP" })






CREATE (lincoln_h1)-[:LINK]->(lincoln)
CREATE (lincoln_h2)-[:LINK]->(lincoln)
CREATE (lincoln_h3)-[:LINK]->(lincoln)




CREATE (ucsb:Host { id: "ucsb", gateway: "IMP", site: "UCSB" })

CREATE (ucsb_h1:Host { id: "ucsb_h1", computer: "360/75" })




CREATE (ucsb_h1)-[:LINK]->(ucsb)



CREATE (carnegie:Host { id: "carnegie", gateway: "IMP", site: "CARNEGIE" })

CREATE (carnegie_h1:Host { id: "carnegie_h1", computer: "PDP-10" })




CREATE (carnegie_h1)-[:LINK]->(carnegie)




CREATE (ucla)-[:LINK]->(ucsb)
CREATE (ucsb)-[:LINK]->(sri)
CREATE (ucla)-[:LINK]->(sri)
CREATE (sri)-[:LINK]->(utah)
CREATE (utah)-[:LINK]->(mit)
CREATE (mit)-[:LINK]->(lincoln)
CREATE (lincoln)-[:LINK]->(case)
CREATE (case)-[:LINK]->(carnegie)
CREATE (carnegie)-[:LINK]->(harvard)
CREATE (harvard)-[:LINK]->(bbn)
CREATE (bbn)-[:LINK]->(mit)
CREATE (bbn)-[:LINK]->(rand)
CREATE (rand)-[:LINK]->(sdc)
CREATE (sdc)-[:LINK]->(utah)
CREATE (rand)-[:LINK]->(stanford)
CREATE (stanford)-[:LINK]->(sri)
CREATE (rand)-[:LINK]->(ucla)
