import json
import xml.etree.ElementTree as ET
import regex as re
import sys
from enum import Enum


class xmlKey(Enum):
    # top level tags
    kanji = "k_ele"
    reading = "r_ele"
    sense = "sense"
    sequence = "ent_seq"
    # second level tags
    # ...


class entryKey(Enum):
    kanji = "kanji"
    reading = "reading"
    context = "context"
    meaning = "meaning"


def parseSense(entry_dict, element) -> bool:
    """grab wrapped meaning value(s) & context(s)"""
    for gloss in element:
        assert(len(gloss) == 0)
        if gloss.tag == "s_inf":
            if entryKey.context.value in entry_dict.keys():
                entry_dict[entryKey.context.value].append(gloss.text)
            else:
                entry_dict[entryKey.context.value] = [gloss.text]
        elif gloss.tag == "gloss":
            entry_dict[entryKey.meaning.value].append(gloss.text)
        elif gloss.tag == "xref":  # ignore cross reference tags for now
            return True
        elif gloss.tag == "dial":  # indicates regional dialect, ignore for now
            return True
        # indicates which reading this meaning refers to, ignore for now
        elif gloss.tag == "stagr" or gloss.tag == "stagk":
            return True
        elif gloss.tag == "field":  # information about the field of application of the entry/sense, ignore for now
            return True
        elif gloss.tag == "lsource":  # indicates loan word source, ignore for now
            return True
        elif gloss.tag == "ant":  # indicates word's antonym, ignore for now
            return True
        else:
            sys.exit(f"Unrecognized sense tag: {gloss.tag}")
    return True


def parseReading(entry_dict, element) -> bool:
    """grab wrapped reading value(s)"""
    for reb in element:
        if reb.tag == "re_nokanji":  # this entry has no Kanji, skip whole entry
            return False
        elif reb.tag == "re_pri":  # encodes priority information,
            return True  # skip tag
        elif reb.tag == "re_restr":  # encodes which kanji this is for, ignore for now
            return True  # skip tag
        elif reb.tag == "re_inf":  # indicates some weirdness about the reading, ignore for now
            return True  # skip tag
        assert reb.tag == "reb", reb.tag
        assert len(reb) == 0, reb[1]
        entry_dict[entryKey.reading.value].append(reb.text)
    return True


def parseKanji(entry_dict, element) -> bool:
    """grab wrapped kanji value(s)"""
    for keb in element:
        if keb.tag == "re_nokanji":
            return False
        elif keb.tag == "ke_pri":  # encodes priority information,
            return True  # skip tag
        elif keb.tag == "ke_inf":  # indicates some weirdness about the kanji, ignore for now
            return True  # skip tag
        assert keb.tag == "keb", keb.tag
        assert len(keb) == 0, reb[1]
        entry_dict[entryKey.kanji.value].append(keb.text)
    return True


def parseEntry(entry) -> dict:
    entry_dict = {
        entryKey.kanji.value: [],
        entryKey.reading.value: [],
        entryKey.meaning.value: [],
    }
    for element in entry:
        # pay no need to the entry sequence number
        if element.tag == xmlKey.sequence.value:
            continue
        elif element.tag == xmlKey.kanji.value:
            if not parseKanji(entry_dict, element):
                return None
        elif element.tag == xmlKey.reading.value:
            if not parseReading(entry_dict, element):
                return None
        elif element.tag == xmlKey.sense.value:
            if not parseSense(entry_dict, element):
                return None
        # report and crash
        else:
            sys.exit(f"Unrecognized tag: {element.tag}")
    return entry_dict


def JMDictParse(name: str):
    tree = ET.parse(name)
    root = tree.getroot()
    jmWithKanji = []
    jmNoKanji = []
    for child in root:
        # skip over any top level tag that isn't a dictionary entry
        if child.tag != "entry":
            continue
        entry = parseEntry(child)
        # discard failed decodings
        if entry == None:
            continue
        elif len(entry[entryKey.kanji.value]) > 0:
            jmWithKanji.append(entry)
        else:
            jmNoKanji.append(entry)
    with open("Kanji.json", "w") as file:
        file.write(json.dumps(jmWithKanji, indent=4, ensure_ascii=False))
        file.close()
    with open("NoKanji.json", "w") as file:
        file.write(json.dumps(jmNoKanji, indent=4, ensure_ascii=False))
        file.close()


if __name__ == "__main__":
    JMDictParse("JMdict_e.xml")
