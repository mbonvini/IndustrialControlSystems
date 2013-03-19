within IndustrialControlSystems.Controllers.Blocks;
model LeadLAG "Lead lag process with tracking mode (and limiter)"
  extends IndustrialControlSystems.Controllers.Interfaces.Block;
  parameter Real mu = 1 "Gain of the system" annotation(Evaluate = true);
  parameter Real Tp = 1 "Pole time constant" annotation(Evaluate = true);
  parameter Real Tz = 2 "Zero time constant" annotation(Evaluate = true);
  parameter Real y_start = 0 "output initial value" annotation(Evaluate = true);
protected
  Real Y "output before saturation";
  Real uF "input filtered";
  parameter Real K1 = mu*(Tp - Tz)/Tp "first gain";
  parameter Real K2 = Tz/(Tp - Tz) "second gain";
initial equation
  y = y_start;
equation
  // assert that Td <> Tp
  assert(abs(Tp - Tz)>1e-4, "Td and Tp must be different!");

  if not ts then
    if AntiWindup then
      y = min(Ymax,max(Ymin,Y));
      Y = K1*K2*u + uF;
      uF + Tp*der(uF) = K1*u;
    else
      y = Y;
      Y = K1*K2*u + uF;
      uF + Tp*der(uF) = K1*u;
    end if;
  else
    if AntiWindup then
      y = min(Ymax,max(Ymin,Y));
      Y = tr;
      uF + eps*der(uF) = y - K1*K2*u;
    else
      y = Y;
      Y = tr;
      uF + eps*der(uF) = y  - K1*K2*u;
    end if;
  end if;
  annotation (Diagram(graphics),
              Icon(graphics={
        Text(
          extent={{-34,28},{68,6}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+sTz"),
        Line(
          points={{-22,0},{64,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-36,-8},{66,-30}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+sTp"),
        Text(
          extent={{-92,12},{10,-10}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="mu")}),    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Lead lag continuous time control block.<br>
  <pre>
   Y(s)        (1 + s*Tz)
   ----  = mu ------------
   U(s)        (1 + s*Tp)
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
end LeadLAG;
