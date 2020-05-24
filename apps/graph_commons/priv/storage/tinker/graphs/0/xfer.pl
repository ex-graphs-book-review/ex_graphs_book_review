#!/usr/bin/perl -n

 print if s|\s*<node id='(\d+)'>|v$1 =|;
 print if s|\s*<data key='labelV'>(\w+)</data>|graph.addVertex(label,'$1',|;
 print if s|\s*<data key='(\w+)'>(\w+)</data>|  '$1','$2',|;
 print if s|\s*</node>|)|;
 
 print if s|\s*<edge id='(\d+)' source='(\d+)' target='(\d+)'>|v$2.addEdge('route', v$3,|;
 print if s|\s*</edge>|)|;

