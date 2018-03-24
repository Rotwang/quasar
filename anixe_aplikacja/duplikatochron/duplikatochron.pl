#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(min);
use constant DANE => "duplikatochron_dane";

my $dane = do "./" . DANE;

# odleglosc levensthein-a, kod zapozyczony z
# http://en.wikibooks.org/wiki/Algorithm_implementation/Strings/Levenshtein_distance#Perl
# algorytm posluzy do oceniania czy dwa ciagi znakow sa podobne do siebie
# jako metoda heurystyczna
sub levenshtein {
    my ($a, $b) = @_;
    my @ar1 = split(//, $b);
    my @ar2 = split(//, $a);

    my @dist;
    $dist[$_][0] = $_ foreach (0 .. @ar1);
    $dist[0][$_] = $_ foreach (0 .. @ar2);

    foreach my $i (1 .. @ar1){
        foreach my $j (1 .. @ar2){
            my $cost = $ar1[$i - 1] eq $ar2[$j - 1] ? 0 : 1;
            $dist[$i][$j] = min(
                $dist[$i - 1][$j] + 1,
                $dist[$i][$j - 1] + 1,
                $dist[$i - 1][$j - 1] + $cost
            );
        }
    }

    return $dist[@ar1][@ar2];
}

# glowny kod programu:
foreach my $nr (0 .. $#{$dane}) {
    foreach my $nr2 ($nr + 1 .. $#{$dane}) {
        my ($dup, $fdup, $dupc) = qw/0 0 0/;
        print "sprawdzam parę: " . $nr . " " . $nr2 . "\n";
        # porównaj numery lotu (dwa skalry (stringi))
        # nie chcemy zmieniac oryginalnych wartosci
        # wiec biale znaki z poczatku i konca wycinamy z kopii
        # przyjmujemy że numer lotu jest wprowadzany recznie wiec moze
        # nastapic ludzki blad (np. literowka)
        (my $lot1 = $dane->[$nr]{"nr_lotu"}) =~ s/(^\s+|\s+$)//g;
        (my $lot2 = $dane->[$nr2]{"nr_lotu"}) =~ s/(^\s+|\s+$)//g;
        if ($lot1 eq $lot2) {
            print "$nr -> $nr2: identyczne pole: numer lotu\n";
            $dup++;
        } elsif (levenshtein($lot1, $lot2) <= 2) {
            print "$nr -> $nr2: podobne pole: numer lotu\n";
            $fdup++;
        }
        $dupc++;
        # porównaj godziny lotu (dwie tablice anonimowe zawierające skalary)
        # załóżmy że aplikacja do generowania bazy zawiera dropbox do wyboru
        # godziny odlotu co eliminuje problem z białymi znakami
        my $gwyl1 = $dane->[$nr]{"godz_wyl"}[0];
        my $gwyl2 = $dane->[$nr2]{"godz_wyl"}[0];
        my $mwyl1 = $dane->[$nr]{"godz_wyl"}[1];
        my $mwyl2 = $dane->[$nr2]{"godz_wyl"}[1];
        if ($gwyl1 == $gwyl2 and $mwyl1 == $mwyl2) {
            print "$nr -> $nr2: identyczne pole: godziny lotu\n";
            $dup++;
        } elsif ((abs($gwyl1 - $gwyl2) <= 5) and (abs($mwyl1 - $mwyl2) <= 5)) {
            print "$nr -> $nr2: podobne pole: godziny lotu\n";
            $fdup++;
        }
        $dupc++;
        if ($dane->[$nr]{"cena"} == $dane->[$nr2]{"cena"}) {
            print "$nr -> $nr2: identyczne pole: cena\n";
            $dup++;
        } elsif (abs($dane->[$nr]{"cena"} - $dane->[$nr2]{"cena"}) <= 10) {
            print "$nr -> $nr2: podobne pole: cena\n";
            $fdup++;
        }
        $dupc++;
        foreach my $f (qw/imie nazwisko narodowosc/) {
            (my $p = $dane->[$nr]{"pasazer"}{$f}) =~ s/(^\s+|\s+$)//g;
            (my $q = $dane->[$nr2]{"pasazer"}{$f}) =~ s/(^\s+|\s+$)//g;
            if ($p eq $q) {
                print "$nr -> $nr2: " . "identyczne pole: " . $f . "\n";
                $dup++;
            } elsif (levenshtein($p, $q) <= 2) {
                print "$nr -> $nr2: " . "podobne pole: " . $f . "\n";
                $fdup++;
            }
            $dupc++;
        }
        (my $se_do1 = $dane->[$nr]{"pasazer"}{"nr_do"}[0]) =~ s/(^\s+|\s+$)//g;
        (my $se_do2 = $dane->[$nr2]{"pasazer"}{"nr_do"}[0]) =~ s/(^\s+|\s+$)//g;
        (my $nr_do1 = $dane->[$nr]{"pasazer"}{"nr_do"}[1]) =~ s/(^\s+|\s+$)//g;
        (my $nr_do2 = $dane->[$nr2]{"pasazer"}{"nr_do"}[1]) =~ s/(^\s+|\s+$)//g;
        if ($se_do1 eq $se_do2) {
            print "$nr -> $nr2: identyczne pole: seria dowodu\n";
            $dup++;
        } elsif (levenshtein($se_do1, $se_do2) == 1) {
            print "$nr -> $nr2: podobne pole: seria dowodu\n";
            $fdup++;
        }
        $dupc++;
        if ($nr_do1 eq $nr_do2) {
            print "$nr -> $nr2: identyczne pole: nr dowodu\n";
            $dup++;
        } elsif (levenshtein($nr_do1, $nr_do2) <= 2) {
            print "$nr -> $nr2: podobne pole: nr dowodu\n";
            $fdup++;
        }
        $dupc++;
        foreach my $f (keys %{$dane->[$nr]{"pasazer"}{"adres"}}) {
            (my $p = $dane->[$nr]{"pasazer"}{"adres"}{$f}) =~ s/(^\s+|\s+$)//g;
            (my $q = $dane->[$nr2]{"pasazer"}{"adres"}{$f}) =~ s/(^\s+|\s+$)//g;
            if ($p eq $q) {
                print "$nr -> $nr2: " . "identyczne pole: " . $f . "\n";
                $dup++;
            } elsif (levenshtein($p, $q) <= 2) {
                print "$nr -> $nr2: " . "podobne pole " . $f . "\n";
                $fdup++;
            }
            $dupc++;
        }
        print "identycznych / możliwych\n";
        printf "%d / %d (%.2f%%)\n", $dup, $dupc, (($dup/$dupc)*100);
        printf "podobnych / możliwych\n";
        printf "%d / %d (%.2f%%)\n\n", $fdup, $dupc, (($fdup/$dupc)*100);
    }
}
