#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
  DockerRequirement:
    dockerImageId: peptidedb
    dockerFile:
        $include: ./Dockerfile
baseCommand: ['proteomiqon-peptidedb']
inputs:
  inputFile:
    type: File
    inputBinding:
      position: 1
      prefix: -i
  params:
    type: File
    inputBinding:
      position: 2
      prefix: -p
  outputDirectory:
    type: Directory
    inputBinding:
      position: 3
      prefix: -o
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outputDirectory)
        writable: true
      - entry: $(inputs.stageDirectory)
        writable: true
      - entry: "$({class: 'Directory', listing: []})"
        entryname: input.outputDirectory
        writable: true
outputs:
  dir:
    type: Directory
    outputBinding:
      # glob: "*/*.db"
      glob: $(inputs.outputDirectory.basename)
        
        
        
