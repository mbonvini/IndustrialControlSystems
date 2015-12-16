within IndustrialControlSystems.Logical.Timers;
model Timer_OffDelay_Fedge "OFF delay timer model, active on falling edge"
  extends IndustrialControlSystems.Logical.Timers.Interfaces.BaseResidualTimer;
  discrete Boolean run "Flag: true while the timer is counting";
  Real startTime "start time of the timer counting";
  discrete Boolean Sd;
initial equation
  startTime = 0;
  run = false;
equation
  when sample(0,Ts) then
    Sd = S;
    (startTime,run) =
      IndustrialControlSystems.Logical.Timers.Functions.fallingEdge(
        pre(Sd),
        Sd,
        R,
        startTime,
        time,
        pre(run));
    Q = IndustrialControlSystems.Logical.Timers.Functions.odts(
        R,
        PV,
        time,
        startTime,
        run);
    tr = if (not Q) and run then PV - (time - startTime) else PV;
  end when;
annotation(Icon(graphics={Line(
          points={{94,24},{72,24},{72,82},{52,82}},
          color={0,0,0},
          smooth=Smooth.None), Polygon(
          points={{66,62},{72,48},{78,62},{66,62}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,56},{80,34}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Off")}),
Documentation(
info="
  <HTML>
  <h4>Description</h4>
    <p>
    The timer is active after a falling edge of the set signal ( <FONT FACE=Courier>S</FONT> ).<br>
    The output ( <FONT FACE=Courier>Q</FONT> ) of the timer rises up <FONT FACE=Courier>PV</FONT> seconds after the 
    Set ( <FONT FACE=Courier>S</FONT> ) becomes false (falling edge).<br>
    If the Set signal become true while counting, the timer does not stop.<br>
    If the Reset signal ( <FONT FACE=Courier>R</FONT> ) has a rising edge, the output remains false and the timer stops.<br><br>
    
    Images show:
    <ul>
    <li>Set <FONT FACE=Courier>S</FONT> and Reset <FONT FACE=Courier>R</FONT> signals,</li>
    <li>Output <FONT FACE=Courier>Q</FONT>,</li>
    <li>and the remaining time <FONT FACE=Courier>tr</FONT></li>
    </ul>
    
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelayFedge_1.png\"><br>
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelayFedge_2.png\"><br>
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/T_OffDelayFedge_3.png\">
    </p>
  </HTML>", revisions="<html>
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
end Timer_OffDelay_Fedge;
