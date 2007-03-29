#!/usr/bin/perl

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = (
  'all' => [
    qw(
      ptbr_gender
      )
  ]
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '1.01';

=head1 NAME

Lingua::PT::Gender - Decides if a Portuguese proper name is male or female

=head1 SYNOPSIS

  use Lingua::PT::Gender qw/ptbr_gender/;
  
  $result = ptbr_gender("Marco Carnut");
  # $result now holds 1 meaning 'male'
  
  $result = ptbr_gender("Ana Paula");
  # $result = now holds 0 meaning 'female'

=head1 DESCRIPTION

This module provides a routine to decide whether a Portuguese name is male
or female. The algorithm examines a table of suffixes to determine this.

The table was computed using a recursive space subdivision algorithm operating
on a database of about 60,000 proper names.

Typical accuracy is greater than 99%. This makes it useful to find enrollment
errors in databases.

=head2 ptbr_gender

This is the only function in this module. It returns 0 for female or 1 for
male. Comparisons are case insensitive. It expects non-accented letters;
it is your responsibility to strip them beforehand. The routine considers
only the first name (word) on the string; all others are ignored.

A simple filter that gets names from the standard input and prefixes them
with M or F accordingly:

   #!/usr/bin/perl
   
   use Lingua::PT::Gender qw/ptbr_gender/; 

   while (<>)
   {
       print ptbr_gender($_) ? "M" : "F";
       print " $_";
   }
   
=head1 LICENSE

   GPL2 - http://www.gnu.org/licenses/gpl.txt

=head1 AUTHOR

   Marco "Kiko" Carnut <kiko at tempest.com.br>
   http://www.postcogito.org/

=cut

sub ptbr_gender
{
    my ($name) = @_;
    my ($n)=split(/\s+/,$name);
    my $out;
    if ($n =~ /a$/oi) {
        $out=0;
        $out=1 if $n =~ /wilba$|rba$|vica$|milca$|meida$|randa$/oi
               || $n =~ /uda$|rrea$|afa$|^ha$|cha$|oha$|apha$/oi
               || $n =~ /natha$|^elia$|rdelia$|remia$|aja$/oi
               || $n =~ /rja$|aka$|kka$|^ala$|gla$|tila$|vila$/oi
               || $n =~ /cola$|orla$|nama$|yama$|inima$|jalma$/oi
               || $n =~ /nma$|urma$|zuma$|gna$|tanna$|pna$/oi
               || $n =~ /moa$|jara$|tara$|guara$|beira$|veira$/oi
               || $n =~ /kira$|uira$|pra$|jura$|mura$|tura$/oi
               || $n =~ /asa$|assa$|ussa$|^iata$|onata$|irata$/oi
               || $n =~ /leta$|preta$|jota$|ista$|aua$|dua$/oi
               || $n =~ /hua$|qua$|ava$|dva$|^iva$|silva$|ova$/oi
               || $n =~ /rva$|wa$|naya$|ouza$/oi;
    }
    elsif ($n =~ /b$/oi) {
        $out=1;
        $out=0 if $n =~ /inadab$/oi;
    }
    elsif ($n =~ /c$/oi) {
        $out=1;
        $out=0 if $n =~ /lic$|tic$/oi;
    }
    elsif ($n =~ /d$/oi) {
        $out=1;
        $out=0 if $n =~ /edad$|rid$/oi;
    }
    elsif ($n =~ /e$/oi) {
        $out=0;
        $out=1 if $n =~ /dae$|jae$|kae$|oabe$|ube$|lace$|dece$/oi 
               || $n =~ /felice$|urice$|nce$|bruce$|dade$|bede$/oi 
               || $n =~ /^ide$|^aide$|taide$|cide$|alide$|vide$/oi 
               || $n =~ /alde$|hilde$|asenilde$|nde$|ode$|lee$/oi 
               || $n =~ /^ge$|ege$|oge$|rge$|uge$|phe$|bie$/oi 
               || $n =~ /elie$|llie$|nie$|je$|eke$|ike$|olke$/oi 
               || $n =~ /nke$|oke$|ske$|uke$|tale$|uale$|vale$/oi 
               || $n =~ /cle$|rdele$|gele$|tiele$|nele$|ssele$/oi 
               || $n =~ /uele$|hle$|tabile$|lile$|rile$|delle$/oi 
               || $n =~ /ole$|yle$|ame$|aeme$|deme$|ime$|lme$/oi 
               || $n =~ /rme$|sme$|ume$|yme$|phane$|nane$|ivane$/oi 
               || $n =~ /alvane$|elvane$|gilvane$|ovane$|dene$/oi 
               || $n =~ /ociene$|tiene$|gilene$|uslene$|^rene$/oi 
               || $n =~ /vaine$|waine$|aldine$|udine$|mine$/oi 
               || $n =~ /nine$|oine$|rtine$|vanne$|renne$|hnne$/oi 
               || $n =~ /ionne$|cone$|done$|eone$|fone$|ecione$/oi 
               || $n =~ /alcione$|edione$|hione$|jone$|rone$/oi 
               || $n =~ /tone$|rne$|une$|ioe$|noe$|epe$|ipe$/oi 
               || $n =~ /ope$|ppe$|ype$|sare$|bre$|dre$|bere$/oi 
               || $n =~ /dere$|fre$|aire$|hire$|ore$|rre$|tre$/oi 
               || $n =~ /dse$|ese$|geise$|wilse$|jose$|rse$/oi 
               || $n =~ /esse$|usse$|use$|aete$|waldete$|iodete$/oi 
               || $n =~ /sdete$|aiete$|nisete$|ezete$|nizete$/oi 
               || $n =~ /dedite$|uite$|lte$|ante$|ente$|arte$/oi 
               || $n =~ /laerte$|herte$|ierte$|reste$|aue$/oi 
               || $n =~ /gue$|oue$|aque$|eque$|aique$|inique$/oi 
               || $n =~ /rique$|lque$|oque$|rque$|esue$|osue$/oi 
               || $n =~ /ozue$|tave$|ive$|ove$|we$|ye$|^ze$/oi 
               || $n =~ /aze$|eze$|uze$/oi;
    }
    elsif ($n =~ /f$/oi) {
        $out=1;
    }
    elsif ($n =~ /g$/oi) {
        $out=1;
        $out=0 if $n =~ /eig$|heng$|mping$|bong$|jung$/oi;
    }
    elsif ($n =~ /h$/oi) {
        $out=1;
        $out=0 if $n =~ /kah$|nah$|rah$|sh$|beth$|reth$|seth$/oi 
               || $n =~ /lizeth$|rizeth$|^edith$|udith$|ruth$/oi;
    }
    elsif ($n =~ /i$/oi) {
        $out=1;
        $out=0 if $n =~ /elai$|anai$|onai$|abi$|djaci$|glaci$/oi 
               || $n =~ /maraci$|^iraci$|diraci$|loraci$|ildeci$/oi 
               || $n =~ /^neci$|aici$|arici$|^elci$|nci$|oci$/oi 
               || $n =~ /uci$|kadi$|leidi$|ridi$|hudi$|hirlei$/oi 
               || $n =~ /sirlei$|^mei$|rinei$|ahi$|^ji$|iki$/oi 
               || $n =~ /isuki$|^yuki$|gali$|rali$|ngeli$|ieli$/oi 
               || $n =~ /keli$|leli$|neli$|seli$|ueli$|veli$/oi 
               || $n =~ /zeli$|ili$|helli$|kelli$|arli$|wanderli$/oi 
               || $n =~ /hami$|iemi$|oemi$|romi$|tmi$|ssumi$/oi 
               || $n =~ /yumi$|zumi$|bani$|iani$|irani$|sani$/oi 
               || $n =~ /tani$|luani$|^vani$|^ivani$|ilvani$/oi 
               || $n =~ /yani$|^eni$|ceni$|geni$|leni$|ureni$/oi 
               || $n =~ /^oseni$|veni$|zeni$|cini$|eini$|lini$/oi 
               || $n =~ /jenni$|moni$|uni$|mari$|veri$|hri$/oi 
               || $n =~ /aori$|ayuri$|lsi$|rsi$|gessi$|roti$/oi 
               || $n =~ /sti$|retti$|uetti$|aui$|iavi$|^zi$/oi 
               || $n =~ /zazi$|suzi$/oi;
    }
    elsif ($n =~ /j$/oi) {
        $out=1;
    }
    elsif ($n =~ /k$/oi) {
        $out=1;
        $out=0 if $n =~ /nak$|lk$/oi;
    }
    elsif ($n =~ /l$/oi) {
        $out=1;
        $out=0 if $n =~ /mal$|^bel$|mabel$|rabel$|sabel$|zabel$/oi 
               || $n =~ /achel$|thel$|quel$|gail$|lenil$|mell$/oi 
               || $n =~ /ol$/oi;
    }
    elsif ($n =~ /m$/oi) {
        $out=1;
        $out=0 if $n =~ /liliam$|riam$|viam$|miram$|eem$|uelem$/oi 
               || $n =~ /mem$|rem$/oi;
    }
    elsif ($n =~ /n$/oi) {
        $out=1;
        $out=0 if $n =~ /lilian$|lillian$|marian$|irian$|yrian$/oi 
               || $n =~ /ivian$|elan$|rilan$|usan$|nivan$|arivan$/oi 
               || $n =~ /iryan$|uzan$|ohen$|cken$|elen$|llen$/oi 
               || $n =~ /men$|aren$|sten$|rlein$|kelin$|velin$/oi 
               || $n =~ /smin$|rin$|istin$|rstin$|^ann$|ynn$/oi 
               || $n =~ /haron$|kun$|sun$|yn$/oi;
    }
    elsif ($n =~ /o$/oi) {
        $out=1;
        $out=0 if $n =~ /eicao$|eco$|mico$|tico$|^do$|^ho$/oi 
               || $n =~ /ocio$|ako$|eko$|keiko$|seiko$|chiko$/oi 
               || $n =~ /shiko$|akiko$|ukiko$|miko$|riko$|tiko$/oi 
               || $n =~ /oko$|ruko$|suko$|yuko$|izuko$|uelo$/oi 
               || $n =~ /stano$|maurino$|orro$|jeto$|mento$/oi 
               || $n =~ /luo$/oi;
    }
    elsif ($n =~ /p$/oi) {
        $out=1;
        $out=0 if $n =~ /yip$/oi;
    }
    elsif ($n =~ /r$/oi) {
        $out=1;
        $out=0 if $n =~ /lar$|lamar$|zamar$|ycimar$|idimar$/oi 
               || $n =~ /eudimar$|olimar$|lsimar$|lzimar$|erismar$/oi 
               || $n =~ /edinar$|iffer$|ifer$|ather$|sther$/oi 
               || $n =~ /esper$|^ester$|madair$|eclair$|olair$/oi 
               || $n =~ /^nair$|glacir$|^nadir$|ledir$|^vanir$/oi 
               || $n =~ /^evanir$|^cenir$|elenir$|zenir$|ionir$/oi 
               || $n =~ /fior$|eonor$|racyr$/oi;
    }
    elsif ($n =~ /s$/oi) {
        $out=1;
        $out=0 if $n =~ /unidas$|katias$|rces$|cedes$|oides$/oi 
               || $n =~ /aildes$|derdes$|urdes$|leudes$|iudes$/oi 
               || $n =~ /irges$|lkes$|geles$|elenes$|gnes$/oi 
               || $n =~ /^ines$|aines$|^dines$|rines$|pes$/oi 
               || $n =~ /deres$|^mires$|amires$|ores$|neves$/oi 
               || $n =~ /hais$|lais$|tais$|adis$|alis$|^elis$/oi 
               || $n =~ /ilis$|llis$|ylis$|ldenis$|annis$|ois$/oi 
               || $n =~ /aris$|^cris$|^iris$|miris$|siris$/oi 
               || $n =~ /doris$|yris$|isis$|rtis$|zis$|heiros$/oi 
               || $n =~ /dys$|inys$|rys$/oi;
    }
    elsif ($n =~ /t$/oi) {
        $out=1;
        $out=0 if $n =~ /bet$|ret$|^edit$|git$|est$|nett$|itt$/oi;
    }
    elsif ($n =~ /u$/oi) {
        $out=1;
        $out=0 if $n =~ /^du$|alu$|^miharu$|^su$/oi;
    }
    elsif ($n =~ /v$/oi) {
        $out=1;
    }
    elsif ($n =~ /w$/oi) {
        $out=1;
    }
    elsif ($n =~ /x$/oi) {
        $out=1;
    }
    elsif ($n =~ /y$/oi) {
        $out=1;
        $out=0 if $n =~ /may$|anay$|ionay$|lacy$|^aracy$|^iracy$/oi 
               || $n =~ /doracy$|vacy$|aricy$|oalcy$|ncy$|nercy$/oi 
               || $n =~ /ucy$|lady$|hedy$|hirley$|raney$|gy$/oi 
               || $n =~ /ahy$|rothy$|taly$|aely$|ucely$|gely$/oi 
               || $n =~ /kely$|nely$|sely$|uely$|vely$|zely$/oi 
               || $n =~ /aily$|rily$|elly$|marly$|mony$|tamy$|iany$/oi 
               || $n =~ /irany$|sany$|uany$|lvany$|wany$|geny$/oi 
               || $n =~ /leny$|ueny$|anny$|mary$|imery$|smery$/oi 
               || $n =~ /iry$|rory$|isy$|osy$|usy$|ty$/oi;
    }
    elsif ($n =~ /z$/oi) {
        $out=1;
        $out=0 if $n =~ /^inez$|rinez$|derez$|liz$|riz$|uz$/oi;
    }
    return $out;
}

1;
