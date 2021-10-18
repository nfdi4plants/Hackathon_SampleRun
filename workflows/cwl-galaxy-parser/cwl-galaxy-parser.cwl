cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerImageId: cwl-galaxy-parser
    dockerFile:
        $include: ./Dockerfile
baseCommand: [cwl-galaxy-parser]
inputs:
    FileInput1:
        type: File
        inputBinding:
            prefix: --file Input1
            position: 1
            shellQuote: false
    FileInput2:
        type: File
        inputBinding:
            prefix: --file Input2
            position: 2
            shellQuote: false
outputs:
    paramFile:
        type: File
        outputBinding:
            glob: $(runtime.outdir)/galaxyInput.yml
    inputDataFolder:
        type: Directory
        outputBinding:
            glob: $(runtime.outdir)