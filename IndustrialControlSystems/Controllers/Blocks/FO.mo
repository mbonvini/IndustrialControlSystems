within IndustrialControlSystems.Controllers.Blocks;
model FO "First Order process with tracking mode (and limiter)"
  extends IndustrialControlSystems.Controllers.Interfaces.Block;
  parameter Real mu = 1 "Gain of the system" annotation(Evaluate = true);
  parameter Real T = 1 "Pole time constant" annotation(Evaluate = true);
  parameter Real y_start = 0 "output initial value" annotation(Evaluate = true);
protected
  Real Y "output before saturation";
initial equation
  Y = y_start;
equation
  if not ts then
    if AntiWindup then
      y = min(Ymax,max(Ymin,Y));
      // T*der(Y) = mu*u - y;
      der(Y) = 1/T*(mu*u - Y) + 1/eps*(y-Y);
    else
      y = Y;
      T*der(Y) = mu*u - Y;
    end if;
  else
    if AntiWindup then
      y = min(Ymax,max(Ymin,Y));
      Y + eps*der(Y) = tr;
    else
      y = Y;
      Y + eps*der(Y) = tr;
    end if;
  end if;
  annotation (Diagram(graphics),
              Icon(graphics={
        Text(
          extent={{-34,40},{32,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu"),
        Line(
          points={{-48,0},{46,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-42,-2},{36,-42}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+sT")}),   Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  First Order continuous time control block.<br>
  <pre>
   Y(s)         mu
   ----  = ------------
   U(s)      (1+s*T)
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
end FO;
