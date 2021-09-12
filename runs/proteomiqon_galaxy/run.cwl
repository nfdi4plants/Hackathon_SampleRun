cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}
inputs:
    workflowInputParams: File
    inputDataFolder: Directory
steps:
    step1:
            run: ../../workflows/proteomiqon_galaxy/planemo_run.cwl
            in:
                workflowInputParams : workflowInputParams
                inputDataFolder : inputDataFolder
            out: [out_dir]
outputs:
    tutorialworkflow:
        type: Directory
        outputSource: step1/out_dir
