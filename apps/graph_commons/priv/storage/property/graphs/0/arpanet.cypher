CREATE (bbn_n1:Node {gateway:'IMP', site:'BBN'})
CREATE (bbn_n2:Node {gateway:'TIP', site:'BBN'})

CREATE (bbn_h1:Host {computer:'PDP-1'})
CREATE (bbn_h2:Host {computer:'PDP-10'})
CREATE (bbn_h3:Host {computer:'PDP-10'})
CREATE (bbn_h4:Host {computer:'H-316'})

CREATE
(bbn_n2)-[:LINK {protocol:['IMP-to-IMP']}]->(bbn_n1),
(bbn_h1)-[:LINK {protocol:['host-to-IMP']}]->(bbn_n1),
(bbn_h2)-[:LINK {protocol:['host-to-IMP']}]->(bbn_n1),
(bbn_h3)-[:LINK {protocol:['host-to-IMP']}]->(bbn_n1),
(bbn_h4)-[:LINK {protocol:['host-to-IMP']}]->(bbn_n1)
