#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
hints:
  DockerRequirement:
    dockerImageId: peptidedb
      dockerFile:
        $include: ./Dockerfile
inputs:
  # inputtype that declares the directory to be staged?
  stageDirectory:
    type: Directory
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
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outputDirectory)
        writable: true
      - entry: $(inputs.stageDirectory)
        writable: true
outputs:
  dir:
    type: Directory
    outputBinding:
      # glob: "*/*.db"
      glob: $(inputs.outputDirectory.basename)
        
        
        
