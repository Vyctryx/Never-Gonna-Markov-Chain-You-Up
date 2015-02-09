#!/usr/bin/env perl
 
use 5.010000;
#use LWP::Simple;
#use Data::Dumper;
use warnings;
use strict;
use POSIX;
#use JSON qw( decode_json );
#use Getopt::Mixed;

my $args 		= $#ARGV + 1;
my $filename 	= $ARGV[0]; 
my $depth 		= $ARGV[1];
my @leftovers	= "";
# my $str 		= "";
# my %count;
my %freq;
# my @suffixes;
# my @words;

if($args != 2) {
	say "\nUsage: name.pl filename depth\n";
	exit;
}

# say "Number of arguments: $args";
# say "File name: $filename";

# Open the file or kill it with fire.
open(my $fh, '<', $filename) or die "cannot open '$filename' $!";

# While there is data in the file, read a new line.
while (my $line = <$fh>) {
	chomp $line; # om nom nom

	# Split the lines up into single strings and store it in $line
	my @words = split(/\s+/, $line);
	
	# Append the new array of words to our leftover words, if there are any. 
	push(@leftovers, @words);
	@words = @leftovers;
	@leftovers = "";

	say "Words: @words";
	say "No. of words: $#words";

	my $index = 0;

	for (my $i = 0; $i <= $#words - $depth; $i++) {
		my $str = "";
#		say "i = $i";

		for (my $j = 0; $j < $depth; $j++) {
			$str .= ($words[$i + $j] . " ");
#			say "j = $j";
#			say "str = $str";
		}
		
		# I have no idea. Maybe I was doing something about those spaces...?
#		$str =~ s/\s+$//;
		say "Final Str = $str";

		# I can't even.
#		push(@{$freqs->{$str}->{succ_arr}}, $words[$i + $depth]);

		# Add to our hash. we may need to chomp the str to eliminate the space
		# on the end, but we'll see.
		if (exists $freq{$str}){
			say "This key already exists!";

#			if (exists 
#			my $count = 
			# aaaand oooohhh shiiiiitttt
			# push @{$freq{$str}}, $words[$i + $depth];
			
		}
#		else {
		
		push @{$freq{$str}}, $words[$i + $depth];
#			push @{$freq{$str}}, 1;
			# $freq{$str} = $words[$i + $depth];
#		}
		
		$index++;
	}
#	splice @words, ($#words - $depth), $depth;

	# create our array of leftover words so we don't run over and divide by zero, etc.
	@leftovers = @words[($#words - $depth + 1)..$#words];
	
	say "Leftover string: @leftovers\n\n";

# my @str = depth number of first entries in @words.
# if there are not that many entries left, we'll need to append the next line
# from the file to the end of that and try again.

# I need to take the first depth amt of words, and:
# - make them into a new key with the proceeding word as their entry, or;
# - check whether their proceeding word exists in the array. Add it or increment its 
#   occurance count.

# Remember you are using suffixes as the key that references an array of possible words and 
# their number of occurrences.

# We also need a way to begin sentences; i.e. when there can only be one, or up to depth - 1
# number of words in the suffix. Shit.

# We also need to deal with lines ending... Shit.

# Shit.

#	foreach my $str (split /\s+/, $line) {
#		$count{$str}++;
#	}
}

 
#foreach my $str (sort keys %count) {
#	printf "%-31s %s\n", $str, $count{$str};
#}

# print "$_ -> $freq{$_}\n" for (keys %freq);

for my $word_combos ( keys %freq ) {
    print "$word_combos: @{ $freq{$word_combos} }\n";
}


# Next, read out that motherfucker.
# We'll probably do this by creating arrays, and populate them with the each word x number
# of times, where x is the number of occurrences of that word stored in the original array.
# E.g. {'There is'} => ('a', 3, 'one', 2, 'this', 1)
# @possiblities = ('a', 'a', 'a', 'one', 'one', 'this')
# This means that for "This is", 'a' is most likely to be chosen by doing random selection
# from the array.
# We would then chop off 'There' and append 'a' to form our next prefix. E.g. "is a".
# Rinse and repeat...?

# Ugh.

say "\nMOVING RIGHT ALONG\n";

# This is a testy random thing.
#my @hash_keys    	= keys %freq;

#my $random_key		= $hash_keys[rand @hash_keys];
#my $random_key 	= "gonna ";
# This is the amount of array entries for that key
#my $random_value 	= $#{$freq{$random_key}} + 1;
# This is the randomly chosen array index
#my $random_arr 	= int(rand($random_value));
# This is the word at that index in the array
#my $entry 		 	= $freq{$random_key}[$random_arr];

#say "Your random key is: $random_key";
#say "Number of array entries: $random_value";
#say "Random selection: $random_arr";
#say "Which is the word: $entry";

# choose a random key.
# choose entries of arrays for that key.
# our next key will be the second word of the key, plus the chose word.
# rinse and repeat while there are still keys or until we hit a certain
# number of thingos.

my $num_paragraphs 	= 1;
my $output			= "";
my $current_str		= "";
my $count 			= 0;
my $lim				= 50;

#for (my $i = 0; $i < $num_paragraphs; $i++) {

	my @hash_keys		= keys %freq;

	# This is a randomly selected hash key
	my $random_key		= $hash_keys[rand @hash_keys];
	$current_str = $current_str . $random_key;

#	while (defined ($random_key)) {
	while ($count < $lim) {

		# This is the amount of array entries for that key
		my $random_value 	= $#{$freq{$random_key}} + 1;
		# This is the randomly chosen array index
		my $random_arr 		= int(rand($random_value));
		# This is the word at that index in the array
		my $entry 		 	= $freq{$random_key}[$random_arr];
		
#		my @words = split(/\s+/, $random_key);
#		@words = @words[($#words - $depth + 1)..$#words];
#		push @words, 
#		my $str .= ($words[$i + $j] . " ");

		say "Your random key is: $random_key";
		say "Number of array entries: $random_value";
		say "Random selection: $random_arr";
		say "Which is the word: $entry";


	#	$random_key =~ s/^\S+\s*//;
		$random_key 	=~ s/^\s*\S+\s*//;
		$random_key 	= $random_key . $entry . " ";
		$current_str 	= $current_str . $entry . " ";

		say "Next key is: $random_key";

		$count++;
	}

	say "Readout:\n$current_str\n";
#}



		

