within IndustrialControlSystems.Logical.Timers;
model Timer_On_Redge "ON timer model, active on rising edge"
  extends IndustrialControlSystems.Logical.Timers.Interfaces.BaseResidualTimer;
  Boolean run "Flag: true while the timer is counting";
  Real startTime "start time of the timer counting";
  Boolean S_hold
    "This variable is kept on by a rising edge of set signal until a rising edge of reset signal.";
  discrete Boolean Sd;
  discrete Boolean Shd;
initial equation
  startTime = 0;
  run = false;
equation
  when sample(0,Ts) then
    Sd = S;
    Shd = S_hold;
    S_hold = IndustrialControlSystems.Logical.Timers.Functions.hold(
        pre(Sd),
        Sd,
        R,
        pre(Shd));
    startTime =
      IndustrialControlSystems.Logical.Timers.Functions.positiveEdge(
        pre(Sd),
        Sd,
        R,
        startTime,
        time);
    (run,Q) = IndustrialControlSystems.Logical.Timers.Functions.tim(
        S_hold,
        R,
        PV,
        time,
        startTime);
    tr = if (Q) then PV - (time - startTime) else 0.0;
  end when;
annotation (Diagram,Icon(graphics={Line(
          points={{40,26},{62,26},{62,84},{84,84}},
          color={0,0,0},
          smooth=Smooth.None), Polygon(
          points={{56,52},{62,66},{68,52},{56,52}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,60},{80,38}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Pos")}),
Documentation(
info="
  <HTML>
    <h4>Description</h4>
    <p>
    The timer is actived when the set signal ( <FONT FACE=Courier>S</FONT> ) becomes true (on the rising edge of <FONT FACE=Courier>S</FONT> ).<br>
    The output ( <FONT FACE=Courier>Q</FONT> ) of the timer rises up when <FONT FACE=Courier>S</FONT> becomes true and remains 
    high for <FONT FACE=Courier>PV</FONT> seconds.<br>
    If the Set signal become false while counting, the timer does not stop.<br>
    If the reset signal ( <FONT FACE=Courier>R</FONT> ) becomes true (a rising edge is detected) the output becomes false and the timer stops.<br><br>
    
    Images show:
    <ul>
    <li>Output <FONT FACE=Courier>Q</FONT>,</li>
    <li>Set <FONT FACE=Courier>S</FONT> and Reset <FONT FACE=Courier>R</FONT> signals,</li>
    <li>and the remaining time <FONT FACE=Courier>tr</FONT></li>
    </ul>
    
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/Timer_On_Redge_1.png\"><br>
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/Timer_On_Redge_2.png\"><br>
    <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Timers/Timer_On_Redge_3.png\">
    </p>
    </HTML>
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
end Timer_On_Redge;
