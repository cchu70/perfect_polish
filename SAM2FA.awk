# Split a sorted sam file into primary and secondary files 

BEGIN 
{
	currID=""; 
	currSeq="";	
	prefix="something"
}
{
if (currID!=$1) {
	currID=$1; 
	currSeq=$10; 
	print ">"$1";"$2";"$3";"$4";"$5";P\n"$10 >> prefix.primary;
	} 
else if (currSeq) { 
	print ">"$1";"$2";"$3";"$4";"$5";S\n"currSeq; 
	currSeq=""; 
	}
}