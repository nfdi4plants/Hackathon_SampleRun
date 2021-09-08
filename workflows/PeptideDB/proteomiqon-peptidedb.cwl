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
    type: string
    inputBinding:
      position: 3
      prefix: -o
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: inputs.outputDirectory
        writable: true
outputs:
  db:
    type: File
    outputBinding:
      glob: "*/*.db"
  dbFolder:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirectory)
        
        
        
