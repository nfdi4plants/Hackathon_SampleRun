cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}
inputs:
    Input1: File
    Input2: File

steps:
    preprocessing:
            run: ../../workflows/cwl-galaxy-parser/cwl-galaxy-parser.cwl
            in:
                FileInput1: Input1
                FileInput2: Input2
            out: [paramFile, inputDataFolder]
    step1:
            run: ../../workflows/proteomiqon_galaxy/planemo_run.cwl
            in:
                workflowInputParams: preprocessing/paramFile
                inputDataFolder: preprocessing/inputDataFolder
            out: [out_dir]
outputs:
    tutorialworkflow:
        type: Directory
        outputSource: step1/out_dir
