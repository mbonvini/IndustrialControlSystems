within IndustrialControlSystems.Applications.ControlProblems;
package DecoupledControl "Example of decoupled control"
  extends IndustrialControlSystems.Icons.ExamplesPackage;





  annotation (Documentation(
info="<html>
<p><b>Description</b> </p>
<p>
The 2x2 process reported below has to be controlled<br/><br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Process.png\"/><br/><br/>
The process is controlled using a decoupler and two PIs ( R1(s) and R2(s) ), each one controlling the corresponding output signal.<br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/DecouplerController.png\"/><br/><br/>
The goal of the control system is to maintain the output of the processe as close as possible to the set point references,<br>
avoiding the cross effects between the first input and the second output and vice versa.<br><br>

The package contains two models in which the process has been controlled using the decoupler
(see <a href=\"modelica://IndustrialControlSystems.Applications.ControlProblems.DecoupledControl.DecoupledControl\">DecoupledControl</a> )
and not
(see <a href=\"modelica://IndustrialControlSystems.Applications.ControlProblems.DecoupledControl.NoDecoupledControl\">NoDecoupledControl</a> )

<br><br>
Process Variables and set point references without decoupler<br>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/NoDecouplerPV.png\"/><br/><br>
Process Variables and set point references with decoupler<br>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/DecouplerPV.png\"/><br/><br/>

The images show how the different control schemes react to the set point changes. The decoupler based scheme performs better than the one without.<br><br>
</html>"));
end DecoupledControl;
