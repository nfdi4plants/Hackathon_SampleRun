
cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}

inputs:
  cores: int
  db: File
  stage: Directory
  outputMzML: Directory
  outputPSM: Directory
  outputPSMStats: Directory
  outputQuant: Directory
  outputProt: Directory
  inputMzML: Directory
  paramsMzML: File
  paramsPSM: File
  paramsPSMStats: File
  paramsPSMBasedQuant: File
  paramsProt: File

steps:
  MzMLToMzlite:
    run: ./../../workflows/MzMLToMzlite/proteomiqon-mzmltomzlite.cwl
    in:
      stageDirectory: stage
      inputDirectory: inputMzML
      params: paramsMzML
      outputDirectory: outputMzML
      parallelismLevel: cores
    out: [dir]
  PeptideSpectrumMatching:
    run: ./../../workflows/PeptideSpectrumMatching/proteomiqon-peptidespectrummatching.cwl
    in:
      stageDirectory: stage
      inputDirectory: MzMLToMzlite/dir
      database: db
      params: paramsPSM
      outputDirectory: outputPSM
      parallelismLevel: cores
    out: [dir]
  PSMStatistics:
    run: ./../../workflows/PSMStatistics/proteomiqon-psmstatistics.cwl
    in:
      stageDirectory: stage
      inputDirectory: PeptideSpectrumMatching/dir
      database: db
      params: paramsPSMStats
      outputDirectory: outputPSMStats
      parallelismLevel: cores
    out: [dir]
  PSMBasedQuantification:
    run: ./../../workflows/PSMBasedQuantification/proteomiqon-psmbasedquantification.cwl
    in:
      stageDirectory: stage
      inputDirectoryI: MzMLToMzlite/dir
      inputDirectoryII: PSMStatistics/dir
      database: db
      params: paramsPSMBasedQuant
      outputDirectory: outputQuant
      parallelismLevel: cores
    out: [dir]
  ProteinInference:
    run: ./../../workflows/ProteinInference/proteomiqon-proteininference.cwl
    in:
      stageDirectory: stage
      inputDirectory: PSMStatistics/dir
      database: db
      params: paramsProt
      outputDirectory: outputProt
    out: [dir]

outputs:
  mzlite:
    type: Directory
    outputSource: MzMLToMzlite/dir
  psm:
    type: Directory
    outputSource: PeptideSpectrumMatching/dir
  psmStats:
    type: Directory
    outputSource: PSMStatistics/dir
  quant:
    type: Directory
    outputSource: PSMBasedQuantification/dir
  prot:
    type: Directory
    outputSource: ProteinInference/dir