#/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

# Making references
# 1 By using a backslash operator on a variable, subroutine, or value.

my $foo = "foo";

# handler
# Comme dans le fichier prelim_refer.pl du dossier OO_Perl
sub handler{
    my $param1 = shift;
    print $param1 . "\n";
}

my $scalarref = \$foo;
my $arrayref = \@ARGV;
my $hashref = \%ENV;
my $coderef = \&handler;

# 2 Reference to an anonymous array
my $arrayref_2 = [1, 2, ['a', 'b', 'c']];
# array of references
my $a = "scalar a";
my @b = (23, "L2", "L3");
my %c = (
            name => "Paille",
            first_name => "Larry"
);#print Dumper(%c);exit();
# Either (see http://perldoc.perl.org/perlref.html, 2.)
# Taking a reference...
# Either
my @list = (\$a, \@b, \%c);
# Or
#my @list = \($a, @b, %c);
# \(@foo) returns a list of references of the contents of @foo
my @list_of_ref_b = \(@b);#print Dumper(@list_of_ref_b);#exit();
my $list_of_ref_c = \%c; #print Dumper($list_of_ref_c);

# 3 Reference to a anonymous hashref
# Using curly brackets
my $hashref_3 = {
                'Adam' => 'Eve',
                'Clyde' => 'Bonnie',
};

# Page http://perldoc.perl.org/perlref.html
# For example, if you wanted a function to make a new hash and return a reference to it
sub hashem
{
    #print Dumper(@_); exit();
    #{@_} #silently wrong

    # At page http://perldoc.perl.org/perlsub.html
    # If no return is found and if the last statement is an expression, its value is returned.
    #+{@_} #ok

    return {@_}; #ok
}
my $hashref_with_sub = hashem(%c);
#print Dumper($hashref_with_sub);

# Page http://perldoc.perl.org/perlref.html
# On the other hand, if you want the other meaning (the BLOCK) ...
sub showem
{
    print Dumper(@_);
    #{@_} # ambiguous (currently ok, but may change)
    {; @_} #ok
    #{ return @_ } #ok
}
#my $for_use_showem = showem(%c);
my $for_use_showem = showem((1 + 2), 42);
#print Dumper($for_use_showem);
print $for_use_showem . "\n";

# From page http://stackoverflow.com/questions/1617546/whats-the-history-of-the-in-front-of-a-hashref-that-disambiguates-from-a-code
print (1 + 2), 42;
print "\n";
print +(1 + 2), 42; # Prints 3 and 42.
print "\n";
#exit();

# 4 A reference to an anonymous subroutine can be created by using sub without a subname
my $coderef_4 = sub
{
    print "Boink!\n";
};

# closures
sub newprint
{
    my $x = shift;
    return sub
    {
        my $y = shift;
        print "$x, $y!\n";
    };
}
#newprint ("Str1", "str2");
my $h = newprint("Howdy");
my $g = newprint("Greetings");

# Time passes

&$h("world");
&$g("earthlings");

# 5

# 7 *foo{THING}
my $scalarref_7 = *foo{SCALAR}; # returns \undef
print Dumper($scalarref_7);
# our seen at page http://stackoverflow.com/questions/6505654/how-do-i-do-the-same-thing-as-reference-using-typeglob-in-perl
our $foo_7 = 4555;
my $scalarref_7_2 = *foo_7{SCALAR}; # returns \4555
print Dumper($scalarref_7_2);

# *********************************Dereferencing*********************************
# 1
print "$$scalarref\n";
print @$arrayref[0] . "\n";
print %$hashref{OS} . "\n";
&handler("In sub handler");
# At page http://perldoc.perl.org/perlref.html
print $arrayref_2->[2][1] . "\n";
# Another syntax
print $arrayref_2->[2]->[1] . "\n";

# 2
print ${$list[0]} . "\n";
# Either
#print @{$list[1]}[1] . "\n";
# Or
print $list[1]->[1] . "\n";
print ${$list_of_ref_b[0]} . "\n";
# Either
#print ${$list_of_ref_c}{"name"} . "\n";
# Or
print $list_of_ref_c->{"name"} . "\n";

# 3
&$coderef_4();

# 7
print "\$\$scalarref_7_2 = " . $$scalarref_7_2 . "\n";