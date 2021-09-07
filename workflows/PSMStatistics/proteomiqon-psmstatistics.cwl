#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
  DockerRequirement:
    dockerImageId: psmstatistics
    dockerFile:
        $include: ./Dockerfile
baseCommand: ['proteomiqon-psmstatistics']
inputs:
  # inputtype that declares the directory to be staged?
  stageDirectory:
    type: Directory
  inputDirectory:
    type: Directory
    inputBinding:
      position: 1
      prefix: -i
  database:
    type: File
    inputBinding:
      position: 2
      prefix: -d
  params:
    type: File
    inputBinding:
      position: 3
      prefix: -p
  outputDirectory:
    type: string
    inputBinding:
      position: 4
      prefix: -o
  parallelismLevel:
    type: int
    inputBinding:
      position: 5
      prefix: -c
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.inputDirectory)
        writable: true
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "psmstats"
        writable: true
outputs:
  dir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirectory)
