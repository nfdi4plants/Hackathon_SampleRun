
cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}

inputs:
  cores: int
  outputDB: string
  outputMzML: string
  outputPSM: string
  outputPSMStats: string
  outputQuant: string
  outputProt: string
  inputDB: File
  inputPSM: Directory
  paramsDB: File
  paramsMzML: File
  paramsPSM: File
  paramsPSMStats: File
  paramsPSMBasedQuant: File
  paramsProt: File

steps:
  #MzMLToMzlite:
  #  run: ./../../workflows/MzMLToMzlite/proteomiqon-mzmltomzlite.cwl
  #  in:
  #    stageDirectory: stage
  #    inputDirectory: inputMzML
  #    params: paramsMzML
  #    outputDirectory: outputMzML
  #    parallelismLevel: cores
  #  out: [dir]
  PeptideDB:
    run: ./../../workflows/PeptideDB/proteomiqon-peptidedb.cwl
    in:
      inputFile: inputDB
      params: paramsDB
      outputDirectory: outputDB
    out: [db, dbFolder]
  PeptideSpectrumMatching:
    run: ./../../workflows/PeptideSpectrumMatching/proteomiqon-peptidespectrummatching.cwl
    in:
      inputDirectory: inputPSM
      database: PeptideDB/db
      params: paramsPSM
      outputDirectory: outputPSM
      parallelismLevel: cores
    out: [dir]
  PSMStatistics:
    run: ./../../workflows/PSMStatistics/proteomiqon-psmstatistics.cwl
    in:
      inputDirectory: PeptideSpectrumMatching/dir
      database: PeptideDB/db
      params: paramsPSMStats
      outputDirectory: outputPSMStats
      parallelismLevel: cores
    out: [dir]
  PSMBasedQuantification:
    run: ./../../workflows/PSMBasedQuantification/proteomiqon-psmbasedquantification.cwl
    in:
      inputDirectoryI: inputPSM
      inputDirectoryII: PSMStatistics/dir
      database: PeptideDB/db
      params: paramsPSMBasedQuant
      outputDirectory: outputQuant
      parallelismLevel: cores
    out: [dir]
  ProteinInference:
    run: ./../../workflows/ProteinInference/proteomiqon-proteininference.cwl
    in:
      inputDirectory: PSMStatistics/dir
      database: PeptideDB/db
      params: paramsProt
      outputDirectory: outputProt
    out: [dir]

outputs:
  #mzlite:
  #  type: Directory
  #  outputSource: MzMLToMzlite/dir
  peptidedb:
    type: Directory
    outputSource: PeptideDB/dbFolder
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