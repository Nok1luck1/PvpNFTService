import React from "react";
import MyNavbar from "../components/MyNavbar";
import eel from "../images/eel.png";
import skate from "../images/skate.png";
import shark from "../images/shark.png";
import anabas from "../images/anabas.png";
import perch from "../images/perch.png";
import piranha from "../images/piranha.png";
import dolphin from "../images/dolphin.png";
import flounder from "../images/flounder.png";
import laskir from "../images/laskir.png";

export default function FishInfo() {
  return (
    <>
      <MyNavbar />
      <div className="fish-info">
        <div className="fish">
          <img className="logo" src={eel} alt="Eel" />
          Eel <br /> Eels are ray-finned fish belonging to the order
          Anguilliformes, which consists of eight suborders, 19 families, 111
          genera, and about 800 species. Eels undergo considerable development
          from the early larval stage to the eventual adult stage and are
          usually predators. The term "eel" is also used for some other
          eel-shaped fish, such as electric eels (genus Electrophorus), spiny
          eels (family Mastacembelidae), swamp eels (family Synbranchidae), and
          deep-sea spiny eels (family Notacanthidae). However, these other
          clades evolved their eel-like shapes independently from the true eels.
          Eels live both in salt and fresh water, and some species are
          catadromous.
        </div>
        <div className="fish">
          <img className="logo" src={skate} alt="Skate" />
          Skate <br /> Skates are cartilaginous fish belonging to the family
          Rajidae in the superorder Batoidea of rays. More than 150 species have
          been described, in 17 genera. Softnose skates and pygmy skates were
          previously treated as subfamilies of Rajidae (Arhynchobatinae and
          Gurgesiellinae), but are now considered as distinct families.
          Alternatively, the name "skate" is used to refer to the entire order
          of Rajiformes (families Anacanthobatidae, Arhynchobatidae,
          Gurgesiellidae and Rajidae). Members of Rajidae are distinguished by a
          stiff snout and a rostrum that is not reduced.
        </div>
        <div className="fish">
          <img className="logo" src={shark} alt="Shark" />
          Shark <br /> Sharks are a group of elasmobranch fish characterized by
          a cartilaginous skeleton, five to seven gill slits on the sides of the
          head, and pectoral fins that are not fused to the head. Modern sharks
          are classified within the clade Selachimorpha (or Selachii) and are
          the sister group to the Batoidea (rays and kin). Some sources extend
          the term "shark" as an informal category including extinct members of
          Chondrichthyes (cartilaginous fish) with a shark-like morphology, such
          as hybodonts.
        </div>
        <div className="fish">
          <img className="logo" src={anabas} alt="Anabas" />
          Anabas <br /> Anabas is a genus of climbing gouramies native to
          southern and eastern Asia. In the wild, Anabas species grow up to 30
          cm (1 ft) long. They inhabit both brackish and fresh water. Anabas
          species possess a labyrinth organ, a structure in the fish's head
          which allows it to breathe atmospheric oxygen, so it can be out of
          water for an extended period of time (6–8 hr), hence its name from the
          Greek anabainein ‘walk up’, from ana- ‘up’ + bainein ‘go’. They are
          carnivorous, living on a diet of water invertebrates and their larvae,
          and - in contrast to most of their relatives - are scatter spawners
          with no parental care. Species are found in South Asia, including
          India, Sri Lanka, Bangladesh, Burma, Indonesia, Malaysia, Thailand,
          Cambodia, and the Philippines.
        </div>
        <div className="fish">
          <img className="perch" src={perch} alt="Perch" />
          Perch <br /> Perch is a common name for fish of the genus Perca,
          freshwater gamefish belonging to the family Percidae. The perch, of
          which three species occur in different geographical areas, lend their
          name to a large order of vertebrates: the Perciformes, from the Greek:
          πέρκη (perke), simply meaning perch, and the Latin forma meaning
          shape. Many species of freshwater gamefish more or less resemble
          perch, but belong to different genera. In fact, the exclusively
          saltwater-dwelling red drum is often referred to as a red perch,
          though by definition perch are freshwater fish. Though many fish are
          referred to as perch as a common name, to be considered a true perch,
          the fish must be of the family Percidae.
        </div>
        <div className="fish">
          <img className="logo" src={piranha} alt="Piranha" />
          Piranha <br />A piranha is one of a number of freshwater fish in the
          family Serrasalmidae, or the subfamily Serrasalminae within the tetra
          family, Characidae in order Characiformes. These fish inhabit South
          American rivers, floodplains, lakes and reservoirs. Although often
          described as extremely predatory and mainly feeding on fish, their
          dietary habits vary extensively, and they will also take plant
          material, leading to their classification as omnivorous.
        </div>
        <div className="fish">
          <img className="logo" src={dolphin} alt="Dolphin" />
          Dolphin <br /> A dolphin is an aquatic mammal within the infraorder
          Cetacea. Dolphin species belong to the families Delphinidae (the
          oceanic dolphins), Platanistidae (the Indian river dolphins), Iniidae
          (the New World river dolphins), Pontoporiidae (the brackish dolphins),
          and the extinct Lipotidae (baiji or Chinese river dolphin). There are
          40 extant species named as dolphins.
        </div>
        <div className="fish">
          <img className="logo" src={flounder} alt="Flounder" />
          Flounder <br /> Flounders ambush their prey, feeding at soft muddy
          areas of the sea bottom, near bridge piles, docks, and coral reefs. A
          flounder's diet consists mainly of fish spawn, crustaceans,
          polychaetes and small fish. Flounder typically grow to a length of
          22–60 centimeters (8.7–23.6 in), and as large as 95 centimeters (37
          in). Their width is about half their length. Male Platichthys have
          been found up to 130 km (80 mi) off the coast of northern Sardinia,
          sometimes with heavy encrustations of various species of barnacle.
          Fluke, a type of flounder, are being farm raised in open water by
          Mariculture Technologies in Greenport, New York.
        </div>
        <div className="fish">
          <img className="logo" src={laskir} alt="Laskir" />
          Laskir <br /> Laskir, or crucian carp (lat. Diplodus annularis), is a
          species of ray-finned fish from the family of spars. It is found in
          the eastern Atlantic: Madeira, Canary Islands, also off the coast of
          Portugal, north to the Bay of Biscay, in the Mediterranean, the Black
          and Azov Seas.
        </div>
      </div>
    </>
  );
}
