#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
  DockerRequirement:
    dockerImageId: psmbasedquantification
    dockerFile:
        $include: ./Dockerfile
baseCommand: ['proteomiqon-psmbasedquantification']
inputs:
  inputDirectoryI:
    type: Directory
    inputBinding:
      position: 1
      prefix: -i
  inputDirectoryII:
    type: Directory
    inputBinding:
      position: 2
      prefix: -ii
  database:
    type: File
    inputBinding:
      position: 3
      prefix: -d
  params:
    type: File
    inputBinding:
      position: 4
      prefix: -p
  outputDirectory:
    type: string
    inputBinding:
      position: 5
      prefix: -o
  parallelismLevel:
    type: int
    inputBinding:
      position: 6
      prefix: -c
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.inputDirectoryI)
        writable: true
      - entry: $(inputs.inputDirectoryII)
        writable: true
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "quant"
        writable: true
outputs:
  dir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirectory)

        
        
        
