within IndustrialControlSystems.Controllers.Blocks;
model I "Integrator with tracking mode (and limiter)"
  extends IndustrialControlSystems.Controllers.Interfaces.Block;
  parameter Real T = 1 "Integral time" annotation(Evaluate = true);
  parameter Real y_start = 0 "State initial value" annotation(Evaluate = true);
protected
  Real Y;
initial equation
  y = y_start;
equation
  if AntiWindup then
    if not ts then
      der(Y) = 1/T*u + 1/eps*(y - Y);
      y = max(Ymin,min(Ymax,Y));
    else
      der(Y) = 1/eps*(y - Y);
      y = max(Ymin,min(Ymax,tr));
    end if;

  else
    Y = 0;
    if not ts then
      T*der(y) = u;
    else
      eps*der(y) = (-y + tr);
    end if;
  end if;
  annotation (Icon(graphics={
        Text(
          extent={{-30,40},{36,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1"),
        Text(
          extent={{-30,-4},{36,-38}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="sT"),
        Line(
          points={{-44,0},{50,0}},
          color={0,0,0},
          smooth=Smooth.None)}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Integrator continuous time control block.<br>
  <pre>
   Y(s)      1
   ----  = ------
   U(s)      sT
  </pre>
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>y</FONT> ) saturates
  at the levels specified by <FONT FACE=Courier>Ymin</FONT> and <FONT FACE=Courier>Ymax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT>, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, is the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>y</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  <br><br>
  While the tracking mode is enabled (<FONT FACE=Courier>TS = true</FONT>), the integrator follows the Track Reference signal (<FONT FACE=Courier>TR</FONT>).<br>
  In such a way bumpless transitions are guaranteed.  
  </p>
  </HTML>",
        revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end I;
