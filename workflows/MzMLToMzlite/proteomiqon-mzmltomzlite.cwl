#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
hints:
hints:
  DockerRequirement:
    dockerImageId: mzmltomzlite
      dockerFile:
        $include: ./Dockerfile
inputs:
  # inputtype that declares the directory to be staged?
  stageDirectory:
    type: Directory
  inputDirectory:
    type: Directory
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
  parallelismLevel:
    type: int
    inputBinding:
      position: 4
      prefix: -c
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.inputDirectory)
        writable: true
      #- entry: $(inputs.stageDirectory)
      #  writable: true
      - entry: $(inputs.outputDirectory)
        writable: true
outputs:
  dir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirectory.basename)
        
        
        
