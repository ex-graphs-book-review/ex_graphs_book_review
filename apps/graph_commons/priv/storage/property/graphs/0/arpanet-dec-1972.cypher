// ####
// # ARPANET - Dec 1972 [1,2]
// #
// # [1] RFC-432, N. Neigus (BBN), https://tools.ietf.org/pdf/rfc432.pdf
// # [2] http://mercury.lcs.mit.edu/~jnc/tech/arpalog.html
// ####


//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to RAND)


// Site: UCLA

CREATE (ucla:Node { id: "ucla", type: "IMP", site: "UCLA" })
CREATE (ucla_h1:Host { id: "ucla_h1", type: "360/91" })
CREATE (ucla_h2:Host { id: "ucla_h2", type: "SIGMA-7" })
CREATE (ucla_h1)-[:H_LINK]->(ucla)
CREATE (ucla_h2)-[:H_LINK]->(ucla)


// Site: UCSB

CREATE (ucsb:Node { id: "ucsb", type: "IMP", site: "UCSB" })
CREATE (ucsb_h1:Host { id: "ucsb_h1", type: "360/75" })
CREATE (ucsb_h1)-[:H_LINK]->(ucsb)


// Site: FNWC

CREATE (fnwc:Node { id: "fnwc", type: "TIP", site: "FNWC" })


// Site: XEROX

CREATE (xerox:Node { id: "xerox", type: "316 IMP", site: "XEROX" })


// Site: SRI

CREATE (sri:Node { id: "sri", type: "IMP", site: "SRI" })
CREATE (sri_h1:Host { id: "sri_h1", type: "PDP-10" })
CREATE (sri_h2:Host { id: "sri_h2", type: "PDP-15" })
// CREATE (sri_h3:Host { id: "sri_h3", type: "PDP-10" })
CREATE (sri_h1)-[:H_LINK]->(sri)
CREATE (sri_h2)-[:H_LINK]->(sri)
// CREATE (sri_h3)-[:H_LINK]->(sri)


// Site: UTAH

CREATE (utah:Node { id: "utah", type: "IMP", site: "UTAH" })
CREATE (utah_h1:Host { id: "utah_h1", type: "PDP-10" })
CREATE (utah_h1)-[:H_LINK]->(utah)


// Site: ILLINOIS

CREATE (illinois:Node { id: "illinois", type: "IMP", site: "ILLINOIS" })
CREATE (illinois_h1:Host { id: "illinois_h1", type: "PDP-11" })
CREATE (illinois_h1)-[:H_LINK]->(illinois)


// Site: MIT

CREATE (mit:Node { id: "mit", type: "IMP", site: "MIT" })
CREATE (mit_h1:Host { id: "mit_h1", type: "PDP-10" })
CREATE (mit_h2:Host { id: "mit_h2", type: "PDP-10" })
CREATE (mit_h3:Host { id: "mit_h3", type: "PDP-10" })
CREATE (mit_h4:Host { id: "mit_h4", type: "H-645" })
CREATE (mit_h1)-[:H_LINK]->(mit)
CREATE (mit_h2)-[:H_LINK]->(mit)
CREATE (mit_h3)-[:H_LINK]->(mit)
CREATE (mit_h4)-[:H_LINK]->(mit)


// Site: LINCOLN

CREATE (lincoln:Node { id: "lincoln", type: "IMP", site: "LINCOLN" })
CREATE (lincoln_h1:Host { id: "lincoln_h1", type: "360/67" })
CREATE (lincoln_h2:Host { id: "lincoln_h2", type: "TX2" })
CREATE (lincoln_h3:Host { id: "lincoln_h3", type: "TSP" })
CREATE (lincoln_h1)-[:H_LINK]->(lincoln)
CREATE (lincoln_h2)-[:H_LINK]->(lincoln)
CREATE (lincoln_h3)-[:H_LINK]->(lincoln)


// Site: RADC

CREATE (radc:Node { id: "radc", type: "TIP", site: "RADC" })


// Site: CASE

CREATE (case:Node { id: "case", type: "IMP", site: "CASE" })
CREATE (case_h1:Host { id: "case_h1", type: "PDP-10" })
CREATE (case_h1)-[:H_LINK]->(case)


// Site: GWC

CREATE (gwc:Node { id: "gwc", type: "TIP", site: "GWC" })


// Site: DOCB

CREATE (docb:Node { id: "docb", type: "TIP", site: "DOCB" })


// Site: USC

CREATE (usc:Node { id: "usc", type: "TIP", site: "USC" })
CREATE (usc_h1:Host { id: "usc_h1", type: "PDP-10" })
CREATE (usc_h1)-[:H_LINK]->(usc)


// Site: SDC

CREATE (sdc:Node { id: "sdc", type: "IMP", site: "SDC" })
CREATE (sdc_h1:Host { id: "sdc_h1", type: "DDP-516" })
// CREATE (sdc_h2:Host { id: "sdc_h2", type: "370/145" })
CREATE (sdc_h1)-[:H_LINK]->(sdc)
// CREATE (sdc_h2)-[:H_LINK]->(sdc)


//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)


// Site: UCSD

CREATE (ucsd:Node { id: "ucsd", type: "316 IMP", site: "UCSD" })
CREATE (ucsd_h1:Host { id: "ucsd_h1", type: "MICRO 810" })
// CREATE (ucsd_h2:Host { id: "ucsd_h2", type: "B6700" })
CREATE (ucsd_h1)-[:H_LINK]->(ucla)
// CREATE (ucsd_h2)-[:H_LINK]->(ucla)


// Site: RAND

CREATE (rand:Node { id: "rand", type: "316 IMP", site: "RAND" })
CREATE (rand_h1:Host { id: "rand_h1", type: "IBM 1800" })
// CREATE (rand_h2:Host { id: "rand_h2", type: "360/65" })
CREATE (rand_h1)-[:H_LINK]->(rand)
// CREATE (rand_h2)-[:H_LINK]->(rand)


// Site: USC-ISI

CREATE (usc_isi:Node { id: "usc_isi", type: "IMP", site: "USC-ISI" })
CREATE (usc_isi_h1:Host { id: "usc_isi_h1", type: "PDP-10" })
CREATE (usc_isi_h1)-[:H_LINK]->(usc_isi)


// Site: STANFORD

CREATE (stanford:Node { id: "stanford", type: "IMP", site: "STANFORD" })
CREATE (stanford_h1:Host { id: "stanford_h1", type: "PDP-10" })
CREATE (stanford_h1)-[:H_LINK]->(stanford)


// Site: AMES

CREATE (ames:Node { id: "ames", type: "IMP", site: "AMES" })
CREATE (ames_h1:Host { id: "ames_h1", type: "PDP-10" })
CREATE (ames_h2:Host { id: "ames_h2", type: "PDP-11" })
CREATE (ames_h1)-[:H_LINK]->(ames)
CREATE (ames_h2)-[:H_LINK]->(ames)


// Site: AMES1

CREATE (ames1:Node { id: "ames1", type: "TIP", site: "AMES1" })
CREATE (ames1_h1:Host { id: "ames1_h1", type: "360-67" })
CREATE (ames1_h1)-[:H_LINK]->(ames1)


//
// SEGMENT 3 - Inner Path (Up from CASE to MIT)


// Site: CARNEGIE

CREATE (carnegie:Node { id: "carnegie", type: "IMP", site: "CARNEGIE" })
CREATE (carnegie_h1:Host { id: "carnegie_h1", type: "PDP-10" })
CREATE (carnegie_h2:Host { id: "carnegie_h2", type: "PDP-10" })
CREATE (carnegie_h1)-[:H_LINK]->(carnegie)
CREATE (carnegie_h2)-[:H_LINK]->(carnegie)


// Site: BELVOIR

CREATE (belvoir:Node { id: "belvoir", type: "316 IMP", site: "BELVOIR" })


// Site: SAAC

CREATE (saac:Node { id: "saac", type: "TIP", site: "SAAC" })


// Site: MITRE

CREATE (mitre:Node { id: "mitre", type: "TIP", site: "MITRE" })


// Site: ARPA

CREATE (arpa:Node { id: "arpa", type: "TIP", site: "ARPA" })
CREATE (arpa_h1:Host { id: "arpa_h1", type: "PDP-15" })
CREATE (arpa_h1)-[:H_LINK]->(arpa)


// Site: ETAC

CREATE (etac:Node { id: "etac", type: "TIP", site: "ETAC" })


// Site: NBS

CREATE (nbs:Node { id: "nbs", type: "TIP", site: "NBS" })
CREATE (nbs_h1:Host { id: "nbs_h1", type: "PDP-11" })
CREATE (nbs_h1)-[:H_LINK]->(nbs)


// Site: ABERDEEN

CREATE (aberdeen:Node { id: "aberdeen", type: "316 IMP", site: "ABERDEEN" })


// Site: HARVARD

CREATE (harvard:Node { id: "harvard", type: "IMP", site: "HARVARD" })
CREATE (harvard_h1:Host { id: "harvard_h1", type: "PDP-1" })
CREATE (harvard_h2:Host { id: "harvard_h2", type: "PDP-10" })
CREATE (harvard_h3:Host { id: "harvard_h3", type: "PDP-11" })
CREATE (harvard_h1)-[:H_LINK]->(harvard)
CREATE (harvard_h2)-[:H_LINK]->(harvard)
CREATE (harvard_h3)-[:H_LINK]->(harvard)


// Site: BBN

CREATE (bbn:Node { id: "bbn", type: "IMP", site: "BBN" })
CREATE (bbn_h1:Host { id: "bbn_h1", type: "PDP-1" })
CREATE (bbn_h2:Host { id: "bbn_h2", type: "PDP-10" })
CREATE (bbn_h3:Host { id: "bbn_h3", type: "PDP-10" })
CREATE (bbn_h4:Host { id: "bbn_h4", type: "H-316" })
CREATE (bbn_h1)-[:H_LINK]->(bbn)
CREATE (bbn_h2)-[:H_LINK]->(bbn)
CREATE (bbn_h3)-[:H_LINK]->(bbn)
CREATE (bbn_h4)-[:H_LINK]->(bbn)


// Site: BBN1

CREATE (bbn1:Node { id: "bbn1", type: "TIP", site: "BBN1" })


//
// SEGMENT 4 - Inner Path (Right from HAWAII to AMES)


// Site: HAWAII

CREATE (hawaii:Node { id: "hawaii", type: "TIP", site: "HAWAII" })


//
// SEGMENT 5 - Inner Path (Right from USC-ISI to ETAC)


// Site: TINKER

CREATE (tinker:Node { id: "tinker", type: "316 IMP", site: "TINKER" })
CREATE (tinker_h1:Host { id: "tinker_h1", type: "UNIVAC 418 III" })
CREATE (tinker_h1)-[:H_LINK]->(tinker)


//
// SEGMENT 6 - Inner Path (Right from ABERDEEN to BELVOIR)


//
// SEGMENT 7 - Inner Path (Right from CCA to BBN)


// Site: CCA

CREATE (cca:Node { id: "cca", type: "TIP", site: "CCA" })
CREATE (cca_h1:Host { id: "cca_h1", type: "PDP-10" })
CREATE (cca_h1)-[:H_LINK]->(cca)


// NETWORK (15+7+12+1+2+1+1=39)

//
// SEGMENT 1 - Outer Circuit (Clockwise from UCLA to SDC)
CREATE (ucla)-[:N_LINK]->(ucsb)
CREATE (ucsb)-[:N_LINK]->(fnwc)
CREATE (fnwc)-[:N_LINK]->(xerox)
CREATE (xerox)-[:N_LINK]->(sri)
CREATE (sri)-[:N_LINK]->(utah)
CREATE (utah)-[:N_LINK]->(illinois)
CREATE (illinois)-[:N_LINK]->(mit)
CREATE (mit)-[:N_LINK]->(lincoln)
CREATE (lincoln)-[:N_LINK]->(radc)
CREATE (radc)-[:N_LINK]->(case)
CREATE (case)-[:N_LINK]->(gwc)
CREATE (gwc)-[:N_LINK]->(docb)
CREATE (docb)-[:N_LINK]->(usc)
CREATE (usc)-[:N_LINK]->(sdc)
CREATE (sdc)-[:N_LINK]->(ucla)
//
// SEGMENT 2 - Inner Path (Up from UCLA to SRI)
CREATE (ucla)-[:N_LINK]->(ucsd)
CREATE (ucsd)-[:N_LINK]->(rand)
CREATE (rand)-[:N_LINK]->(usc_isi)
CREATE (usc_isi)-[:N_LINK]->(stanford)
CREATE (stanford)-[:N_LINK]->(ames)
CREATE (ames)-[:N_LINK]->(ames1)
CREATE (ames1)-[:N_LINK]->(sri)
//
// SEGMENT 3 - Inner Path (Up from CASE to MIT)
CREATE (case)-[:N_LINK]->(carnegie)
CREATE (carnegie)-[:N_LINK]->(belvoir)
CREATE (belvoir)-[:N_LINK]->(saac)
CREATE (saac)-[:N_LINK]->(mitre)
CREATE (mitre)-[:N_LINK]->(arpa)
CREATE (arpa)-[:N_LINK]->(etac)
CREATE (etac)-[:N_LINK]->(nbs)
CREATE (nbs)-[:N_LINK]->(aberdeen)
CREATE (aberdeen)-[:N_LINK]->(harvard)
CREATE (harvard)-[:N_LINK]->(bbn)
CREATE (bbn)-[:N_LINK]->(bbn1)
CREATE (bbn1)-[:N_LINK]->(mit)
//
// SEGMENT 4 - Inner Path (Right from HAWAII to AMES)
CREATE (hawaii)-[:S_LINK]->(ames)
//
// SEGMENT 5 - Inner Path (Right from USC-ISI to ETAC)
CREATE (usc_isi)-[:N_LINK]->(tinker)
CREATE (tinker)-[:N_LINK]->(etac)
//
// SEGMENT 6 - Inner Path (Right from ABERDEEN to BELVOIR)
CREATE (aberdeen)-[:N_LINK]->(belvoir)
//
// SEGMENT 7 - Inner Path (Right from CCA to BBN)
CREATE (cca)-[:N_LINK]->(bbn)
