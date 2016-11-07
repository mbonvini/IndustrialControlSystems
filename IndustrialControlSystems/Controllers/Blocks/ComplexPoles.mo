within IndustrialControlSystems.Controllers.Blocks;
model ComplexPoles "Process with complex poles and tracking mode (and limiter)"
  extends IndustrialControlSystems.Controllers.Interfaces.Block;
  parameter Real mu = 1 "Gain of the system" annotation(Evaluate = true);
  parameter Real omega = 1 "natural frequency of the complex poles" annotation(Evaluate = true);
  parameter Real xi = 1 "damping factor" annotation(Evaluate = true);
  parameter Real y_start = 0 "output initial value" annotation(Evaluate = true);
  parameter Real y_der_start = 0 "output initial slope" annotation(Evaluate = true);
protected
  Real Y "output before saturation";
  Real dY "derivative of the output";
initial equation
  y  = y_start;
  dY = y_der_start;
equation

  if not ts then
    if AntiWindup then
      y = min(Ymax,max(Ymin,Y));
      mu*u = Y + 2*xi/omega*dY + der(dY)/(omega^2);
      dY = der(Y);
    else
      y = Y;
      mu*u = Y + 2*xi/omega*dY + der(dY)/(omega^2);
      dY = der(Y);
    end if;
  else
    if AntiWindup then
      y = min(Ymax,max(Ymin,tr));
      Y + eps*der(Y) = tr;
      dY = der(Y);
    else
      y = tr;
      Y + eps*der(Y) = tr;
      dY = der(Y);
    end if;
  end if;
  annotation (Diagram(graphics),
              Icon(graphics={
        Text(
          extent={{-20,16},{38,0}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu"),
        Line(
          points={{-56,-12},{72,-12}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-60,-16},{70,-60}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*xi/w + (s/w)^2")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Complex poles continuous time control block.<br>
  <pre>
   Y(s)                      1
   ----  = mu ------------------------------------
   U(s)        (1 + s*2*xi/omega + (s/omega)^2)
  </pre>
  
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>y</FONT> ) saturates
  at the levels specified by <FONT FACE=Courier>Ymin</FONT> and <FONT FACE=Courier>Ymax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT>, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, is the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>y</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  <br><br>
  While the tracking mode is enabled (<FONT FACE=Courier>TS = true</FONT>), the state variable follows the Track Reference signal (<FONT FACE=Courier>TR</FONT>).<br>
  In such a way bumpless transitions are guaranteed. 
  </p>
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
end ComplexPoles;
