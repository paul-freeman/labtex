#!/usr/bin/env bash
# see CUP manual at: http://www2.cs.tum.edu/projects/cup/

java -jar ../../../../../../cup/java-cup-11b.jar -parser LabParser -symbols LabSymbols ../../../../../../cup/labtex.cup
