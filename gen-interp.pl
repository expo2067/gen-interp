#!/usr/perl5/5.6.1/bin/perl -w


#	
#	
#	
#	
#	
#	
#	

##	expr_list ::= (expr)+
##	expr ::= (expr) | prim
##	prim ::= <some-prim-stuff>

sub prim {
	# "P";
	&Descriptor_3sequence ;
}

sub expr {
	local $res;

	if ( rand() < 0.6 ) {
			$res .= &prim ;
	}
	else {
		$res = "(". &expr . "-" . &expr . ")";
	}
	
	$res;
}

sub expr_list {
	local ($res);
	for (0..2) {
		$res .= &expr . "  ";
	}
	$res;
}

$MorphemeBoundary = "(.)";

@LexiconEntries = (
'astral-liquid',
'spiralling; helical motion',
'acquiescent',
'fire; flame',
'water',
'of the number 4',
'(astral-liquid)',
'crystal; glass; light in motion',
'arbitrary; unrelated',
'winds; gases; other than the liquid or solid state'
);

@Abbreviations = (
'(Discourse-focus)',
'*properName*',
'Adj',
'aerial-entelechic',
'aerial-locative',
'co-primal',
'Agentive',
'aspect',
'compizer',
'thematic',
'Deictic',
'Discourse-focus',
'Discourse-denial',
'influx-agnt',
'influx-clsfier',
'NC',
'prep',
'RelProN',
'tense',
'Adj',
'Adv',
'Agt',
'Apro',
'Aux',
'Bpro',
'caus',
'Comp',
'Conj',
'Dioc',
'Dm',
'imp',
'inc',
'infx',
'ints',
'Ipro',
'NC',
'Neg',
'Num',
'opt',
'Part',
'perf',
'Prep',
'Pres',
'prt',
'pst',
'psv',
'Relpro',
'rflx',
'RelN',
'sf',
'trns',
'Trm',
'V',
'PN'
);

#  These are comments or explanations of the
#		original signal and/or its analysis.
#
#  	<noun-phrase> <adj>
#  	<noun-phrase> <verb-past>
#		<feature>
#
#
@TranslatorComments = (
	'[...]',
	'[=]',
	'[=?=]',
	'[=%=]',
	'[segmentation uncertain]',
	'[alternate gloss]',
	'[local ambiguity threshold approached]',
	'[entelechy focus uncertain]',
	'[lexico-entropic excessive]',
	'[signal degraded]',
	'[lexical-smoothing applied]',
	'[syntax averaging applied]',
	'[thematic scope uncertain]',
	'[imperative scope uncertain]',
	'[equational regime]',
	'[soritical complex suppressed]',
	'[focus-relative ambiguity]',
	'[co-focus ambiguity]',
	'[presumed co-relative]',
	'[unrecognized rhetorical construct]',
	'[unrecognized imperative construct]',
	'[bi-cubic interpolation]',
	'[signal region singularity]'
);

#    [1-4]-{sg|pl}
#
#
@Person = ( 'sg', 'pl' );
@Number = ( '1', '2', '3', '4' );

sub PersonNumber {
	&pick_rand_elem( *Number ) . "-" . &pick_rand_elem( *Person );
}

sub PersonNumberTag {
		local $res .= "-(" . &PersonNumber . ")";
}


sub gen_stuff {
for (;;) {


		$started_new_line = 0;

    # $w = get-word-from Abbreviations array
		$w = &Descriptor_random;

		

    # See if word fits on line.

    $col += length($w) + 1;
    if ($col >= 65) {
        $col = 0;
        print "\n";
				$started_new_line = 1;
    }
    else {
				# Between every 4 (or so) words, print ' ', rather than '-'
        if (rand() < .45) {
        	print ' ';
				}
				else {
        	print "--";
				}
    }

    print $w;


    # Paragraph every 10 sentences or so.

    # if ($w =~ /\.$/) {
    if ( $started_new_line ) {
        if (rand() < .2) {
            print "\n";
            $col = 80;
    				$started_new_line = 0;
        }
    }
}
}

# pick random integer between given A and B
#
#
sub random_ab {
	local ($a,$b) = @_;
	return int(rand($b-$a)) + $a ;
}

# pick i, rand number between 0-th and n-th item in array "Abbreviations"
#  $#the_array -- last index of array the_array
#
sub pick_rand_elem {
	local( *the_array ) = @_;
	$the_array[int(rand($#the_array +1))] ;
}


sub Descriptor_random {
		&pick_rand_elem( *Abbreviations );
}

sub Descriptor_1sequence {
		&Descriptor_random;
}
sub Descriptor_2sequence {
		&Descriptor_sequence(2);
}
sub Descriptor_3sequence {
		&Descriptor_sequence(3);
}
sub Descriptor_5sequence {
		&Descriptor_sequence(5);
}

sub Descriptor_1sequence_nested {
	local ($res);
	for( 0..1 ) {
		$res .= (rand() < 0.3) ? &Descriptor_2sequence : &ScopeDescriptorSequence_nested; 
	}
	$res;
}


sub Descriptor_3sequence_nested {
	local ($res);
	for( 0..4 ) {
		$res .= (rand() < 0.3) ? &Descriptor_random : &ScopeDescriptorSequence_nested; 
	}
	$res;
}

sub Descriptor_sequence {
	local ($i) = @_ ;		# random number; gen up to this many items, hyphen-sep'd
	local ($j, $sld);

	##== print "Descriptor_sequence: input i = $i\n";

	for ( $sld = "", $j=0; $j < $i; $j++) {
		$sld .= &Descriptor_random ;
		$sld .= ( $j < ($i -1) ) ? "-" : "" ;
	} 
	$sld ;	
}

#   <scope-begin> 						::= "["
#   <scope-end> 							::= "]"
#		<scope-plist-begin>	::= "{"
#		<scope-plist-end>		::= "}"
#

$ScopeBegin 			= "[" ;
$ScopeEnd 				= "]" ;
$ScopePlistBegin 	= "{" ;
$ScopePlistEnd 		= "}" ;

sub ScopeTag {
	&Descriptor_3sequence ;
}

# ScopePlist ::= <descriptor-3sequence> [ PersonNumberTag ]
#
#
sub ScopePlist {
	local $res ;
	$res .= &Descriptor_3sequence ;


	if (rand() < 0.1) {
		$res .= "--" . &PersonNumber;
	}

	$res;
}
	

# ie.
#  ScopeDescriptor ::= [ <ScopeTag>{ <ScopePlist> } ]
#
#
sub ScopeDescriptor {
	local $res ;

	$res .= $ScopeBegin ;
	$res .= &ScopeTag ;

	$res .= $ScopePlistBegin;
	$res .= &ScopePlist;
	$res .= $ScopePlistEnd;

	$res .= $ScopeEnd ;
	$res ;
}

#
# ScopeDescriptor_recursive ::= 
#			ScopeBegin { ScopeTag | ScopeDescriptor_recursive } ScopeEnd
#
sub ScopeDescriptor_recursive {
	local $res ;

	$res .= "[";

	if ( rand() < 0.3 ) {
		$res .= &ScopeDescriptor_recursive ;
	} else {
		$res .= &ScopeTag ;
	}
	$res .= "]" ;

	$res ;
}

#
#	ScopeDescriptorSequence_nested ::= ScopeDescriptor_recursive{1,4}
#
sub ScopeDescriptorSequence_nested {
	local ($res, $i, $dcount);
	$dcount = &random_ab(1,4);

	for( $i=0; $i < $dcount; $i++ ) {
		$res .= &ScopeDescriptor_recursive ;
	}
	$res;
}

sub ScopeDescriptorSequence {
	local ($res, $i, $dcount);
	$dcount = &random_ab(1,3);
	for( $i=0; $i < $dcount; $i++ ) {
		$res .= &ScopeDescriptor . ( $i == $dcount-1 ? "" : $MorphemeBoundary );
	}
	$res;
}


sub TransComment {
	&pick_rand_elem( *TranslatorComments ) ;
}

#  primitive Descriptor
#
sub Descriptor_prim {
	&pick_rand_elem( *Abbreviations ) ;
}

#  composite Descriptor
#
sub Descriptor_comp {
	;
}


#
#
#
#
#

sub genTranslatorComment {
    if (rand() < 0.3) {
			" ". &TransComment ; 
    }
}

sub inputline_is_empty_text{
	local ($s) = @_ ;		
	return ( length($s) <= 1 );
}

sub file_interpolate {
	local( $lc ) = 1;
	local( $ddd );

	while (<>) {
	
	  # s/^\W+//;
	  

#==		if ( inputline_is_empty_text($_) ){
#==			print "====empty input line\n" ;
#==		} else {
#==			print "====full  input line\n" ;
#==		}

		# split input-line on ' ' ?
	
		# print "$lc : " ;
		# print input line
		print "$_" ;

		if ( !inputline_is_empty_text($_) ){

			# print parse-specification
			$ddd = &ScopeDescriptorSequence ;
			print "( $ddd )\n" ;
	
			# print translation commentary (possibly)
			print &genTranslatorComment ;
	
			print "\n" x 2;
		}


		$lc++ ;
	

	}
}







#
# main
#
#
#
#

	&file_interpolate ;

#==	for (0..10) {
#==		# print &PersonNumber ;
#==		# print &pick_rand_elem( *Person ) ;
#==		# print &pick_rand_elem( *Number ) ;
#==		# print &ScopeDescriptor_recursive ;
#==
#==		# print &Descriptor_3sequence_nested ;
#==		# print "\n" x 1;
#==		# print &Descriptor_1sequence_nested ;
#==
#==		print &expr_list ;
#==
#==		print "\n" x 3;
#==	}
