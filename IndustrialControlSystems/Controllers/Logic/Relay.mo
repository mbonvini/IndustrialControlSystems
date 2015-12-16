within IndustrialControlSystems.Controllers.Logic;
model Relay "Relay"
  extends IndustrialControlSystems.Controllers.Interfaces.BaseBlock;
  parameter Real Ymax = 1 "maximum output value" annotation(Evaluate = true);
  parameter Real Ymin = 0 "minimum output value" annotation(Evaluate = true);
  parameter Real Th = 0 "input treshold value" annotation(Evaluate = true);
equation
  if Ts > 0 then
    // Discrete time relay
    when sample(0,Ts) then
      if pre(u) >= Th then
        y = Ymax;
      else
        y = Ymin;
      end if;
    end when;
  else
    // Continuous time relay
    if u >= Th then
        y = Ymax;
      else
        y = Ymin;
      end if;
  end if;
  annotation (Icon(graphics={Line(
          points={{-78,-84},{2,-84},{2,86},{78,86}},
          color={0,0,255},
          smooth=Smooth.None), Polygon(
          points={{-10,-8},{2,24},{14,-8},{-10,-8}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  On-Off relay controller.<br>
  <pre>
            1 if u(t) >= 0
   y(t)  = 
            0 if u(t) &lt; 0
  </pre>
  
  <h4>Characteristic</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Logic/RelayChar.png\"><br>
  If the sampling time parameter <FONT FACE=Courier>Ts</FONT> is less or equal to zero, ( <FONT FACE=Courier>Ts &lt;= 0</FONT> )
  The continuous time vesion is used, otherwise the discrete time one.
  
  </p>
  </HTML>",
        revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end Relay;
