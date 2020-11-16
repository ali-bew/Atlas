<?xml version="1.0" encoding="utf-8"?>
<MICE Version="1.1.3.0" Timestamp="2020-11-11 18:31:36.1269349">
  <Settings>
    <ID>59cfa775-a756-42d0-9720-5239464ddf77</ID>
    <Name>New Process</Name>
    <Description />
    <Version>1.0</Version>
    <Compress>False</Compress>
  </Settings>
  <Nodes>
    <Node ID="00fD6Ccf1fbC4ee4" T="NodeReadNifti" V="0.1" X="-27" Y="539" FI="">
      <Inputs />
      <Outputs>
        <IO ID="636583B00C8eeeB0" T="Image4DFloat" N="Image" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="File" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_17\IBSR_17_mask.nii" />
        <SN N="SetNewName" V="False" />
        <SN N="NewName" V="" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="dA0556fDEACF8af0" T="NodeExportNIfTI" V="0.1" X="687" Y="533" FI="">
      <Inputs>
        <IO ID="c6BEb04Fe01FeCbD" T="Image4DFloat" N="In" MI="1" MA="2147483647" />
      </Inputs>
      <Outputs />
      <Settings>
        <SN N="ImagePrefix" V="bias" />
        <SN N="Compress" V="False" />
        <SN N="OutPath" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Bias N4\Validation_Set" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="b073FCB0DFE235Ad" T="NodeRegionShapeKeep" V="0.1" X="115" Y="407" FI="">
      <Inputs>
        <IO ID="C5ff1AAFaDB3B8a6" T="Image4DFloat" N="Label Map" MI="1" MA="1" />
      </Inputs>
      <Outputs>
        <IO ID="B1aA1f2FefC4fe34" T="Image4DBool" N="Mask" MI="1" MA="1" />
        <IO ID="83cce568405762Ae" T="Image4DFloat" N="Kept Labels" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="Keep" V="1" />
        <SN N="Property" V="PhysicalSize" />
        <SN N="Reverse" V="False" />
        <SN N="RunSingle" V="True" />
      </Settings>
    </Node>
    <Node ID="520bBacAeE1306Aa" T="NodeN4BiasFieldCorrection" V="0.1" X="389" Y="485" FI="">
      <Inputs>
        <IO ID="2E8cbb8FDEd4088C" T="Image4DFloat" N="Image" MI="1" MA="1" />
        <IO ID="fACfaB2b13AfD4ec" T="Image4DBool" N="Mask" MI="0" MA="1" />
      </Inputs>
      <Outputs>
        <IO ID="3fBd5cBF1D0aBceD" T="Image4DFloat" N="Output" MI="1" MA="1" />
        <IO ID="73EB62016F10AF2F" T="Image4DFloat" N="Bias Field" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="Convergence" V="0.004" />
        <SN N="FieldW" V="0.15" />
        <SN N="NumOfCp" V="4" />
        <SN N="NumOfbin" V="200" />
        <SN N="SplnOrder" V="3" />
        <SN N="WFNoise" V="0.01" />
        <SN N="DS" V="False" />
        <SN N="SFact" V="2" />
        <SN N="Interpolator" V="Gaussian" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="38817DA7f86CD6cD" T="NodeExportNIfTI" V="0.1" X="680" Y="428" FI="">
      <Inputs>
        <IO ID="CDAAfbacaeffbADb" T="Image4DFloat" N="In" MI="1" MA="2147483647" />
      </Inputs>
      <Outputs />
      <Settings>
        <SN N="ImagePrefix" V="" />
        <SN N="Compress" V="False" />
        <SN N="OutPath" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Bias N4\Validation_Set" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="64b1e4B81a37e4Af" T="NodeCurvatureDiffusion" V="0.1" X="439" Y="367" FI="">
      <Inputs>
        <IO ID="f8BCdD02DCBf361A" T="Image4DFloat" N="Image" MI="1" MA="1" />
      </Inputs>
      <Outputs>
        <IO ID="2dfDcEeA00C518a5" T="Image4DFloat" N="Output" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="Conductance" V="3" />
        <SN N="SUI" V="1" />
        <SN N="TS" V="0.0625" />
        <SN N="It" V="5" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="76fB0ADDF77A7640" T="NodeExportNIfTI" V="0.1" X="684" Y="317" FI="">
      <Inputs>
        <IO ID="6c1416DA6b63117b" T="Image4DFloat" N="In" MI="1" MA="2147483647" />
      </Inputs>
      <Outputs />
      <Settings>
        <SN N="ImagePrefix" V="" />
        <SN N="Compress" V="False" />
        <SN N="OutPath" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\isotropic\Validation_Set" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="06C7DF660A4a1AbE" T="NodeReadNifti" V="0.1" X="162" Y="282" FI="">
      <Inputs />
      <Outputs>
        <IO ID="42CfDE5BCCFEc7bC" T="Image4DFloat" N="Image" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="File" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_17\IBSR_17.nii" />
        <SN N="SetNewName" V="False" />
        <SN N="NewName" V="" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="E323eF3f43dAE17f" T="NodeN4BiasFieldCorrection" V="0.1" X="674" Y="148" FI="">
      <Inputs>
        <IO ID="521dAA1E7AC2ad00" T="Image4DFloat" N="Image" MI="1" MA="1" />
        <IO ID="26Ad3a4dCC1e7252" T="Image4DBool" N="Mask" MI="0" MA="1" />
      </Inputs>
      <Outputs>
        <IO ID="EcA2AfA3af8FCA8A" T="Image4DFloat" N="Output" MI="1" MA="1" />
        <IO ID="6DBcCF556E361CFf" T="Image4DFloat" N="Bias Field" MI="1" MA="1" />
      </Outputs>
      <Settings>
        <SN N="Convergence" V="0.004" />
        <SN N="FieldW" V="0.15" />
        <SN N="NumOfCp" V="4" />
        <SN N="NumOfbin" V="200" />
        <SN N="SplnOrder" V="3" />
        <SN N="WFNoise" V="0.01" />
        <SN N="DS" V="False" />
        <SN N="SFact" V="2" />
        <SN N="Interpolator" V="Gaussian" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="4ce384BEeef24062" T="NodeExportNIfTI" V="0.1" X="890" Y="250" FI="">
      <Inputs>
        <IO ID="CAcD8dDBBAD335fd" T="Image4DFloat" N="In" MI="1" MA="2147483647" />
      </Inputs>
      <Outputs />
      <Settings>
        <SN N="ImagePrefix" V="bias" />
        <SN N="Compress" V="False" />
        <SN N="OutPath" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Bias + Isot\Validation_Set" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
    <Node ID="A7fB4BbD61555C5c" T="NodeExportNIfTI" V="0.1" X="890" Y="78" FI="">
      <Inputs>
        <IO ID="D7c840DcC58EACAC" T="Image4DFloat" N="In" MI="1" MA="2147483647" />
      </Inputs>
      <Outputs />
      <Settings>
        <SN N="ImagePrefix" V="" />
        <SN N="Compress" V="False" />
        <SN N="OutPath" V="C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Bias + Isot\Validation_Set" />
        <SN N="RunSingle" V="False" />
      </Settings>
    </Node>
  </Nodes>
  <Connections>
    <CN ID1="c6BEb04Fe01FeCbD" ID2="73EB62016F10AF2F" />
    <CN ID1="C5ff1AAFaDB3B8a6" ID2="636583B00C8eeeB0" />
    <CN ID1="2E8cbb8FDEd4088C" ID2="42CfDE5BCCFEc7bC" />
    <CN ID1="fACfaB2b13AfD4ec" ID2="B1aA1f2FefC4fe34" />
    <CN ID1="CDAAfbacaeffbADb" ID2="3fBd5cBF1D0aBceD" />
    <CN ID1="f8BCdD02DCBf361A" ID2="42CfDE5BCCFEc7bC" />
    <CN ID1="6c1416DA6b63117b" ID2="2dfDcEeA00C518a5" />
    <CN ID1="521dAA1E7AC2ad00" ID2="2dfDcEeA00C518a5" />
    <CN ID1="26Ad3a4dCC1e7252" ID2="B1aA1f2FefC4fe34" />
    <CN ID1="CAcD8dDBBAD335fd" ID2="6DBcCF556E361CFf" />
    <CN ID1="D7c840DcC58EACAC" ID2="EcA2AfA3af8FCA8A" />
  </Connections>
  <Notes />
</MICE>