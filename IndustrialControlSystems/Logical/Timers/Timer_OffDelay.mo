within IndustrialControlSystems.Logical.Timers;
model Timer_OffDelay "OFF delay timer model"
  extends IndustrialControlSystems.Logical.Timers.Interfaces.BaseResidualTimer;
  Boolean run "Flag: true while the timer is counting";
  Real startTime "start time of the timer counting";
  discrete Boolean Sd;
initial equation
  startTime = 0;
  run = false;
equation
  Sd = S;
  when sample(0,Ts) then
    startTime =
      IndustrialControlSystems.Logical.Timers.Functions.positiveEdge(
        pre(Sd),
        Sd,
        R,
        startTime,
        time);
    (run,Q) = IndustrialControlSystems.Logical.Timers.Functions.odt(
        S,
        R,
        PV,
        time,
        startTime);
    tr = if (not Q) then PV - (time - startTime) else PV;
  end when;
annotation (Icon(graphics={Text(
          extent={{-78,56},{80,34}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Off")}),
          Documentation(info="
  <HTML>
  <h4>Description</h4>
    <p>
    The timer is active after the set signal ( <FONT FACE=Courier>S</FONT> ) becomes true.<br>
    The output ( <FONT FACE=Courier>Q</FONT> ) of the timer rises up <FONT FACE=Courier>PV</FONT> seconds after the 
    Set ( <FONT FACE=Courier>S</FONT> ) becomes true.<br>
    If the Set signal becomes false while counting, the timer stops and the output remains false.<br>
    If the Reset signal ( <FONT FACE=Courier>R</FONT> ) becomes true, the output remains false and the timer stops.<br><br>
    
    Images show:
    <ul>
    <li>Set <FONT FACE=Courier>S</FONT> and Reset <FONT FACE=Courier>R</FONT> signals,</li>
    <li>Output <FONT FACE=Courier>Q</FONT>,</li>
    <li>and the remaining time <FONT FACE=Courier>tr</FONT></li>
    </ul>
    
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelay_1.png\">
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelay_2.png\">
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelay_3.png\">
    </p>
  </HTML>
  ", revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>"));
end Timer_OffDelay;
