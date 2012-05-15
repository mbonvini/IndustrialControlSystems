within IndustrialControlSystems.Controllers.Blocks;
model P "Integrator with tracking mode (and limiter)"
  extends IndustrialControlSystems.Controllers.Interfaces.Block;
  parameter Real Kp = 5 "Proportional gain" annotation(Evaluate = true);
equation
  if not ts then
      y = if AntiWindup then max(Ymin,min(Ymax,Kp*u)) else Kp*u;
    else
      y = if AntiWindup then max(Ymin,min(Ymax,tr)) else tr;
  end if;
  annotation (Icon(graphics={Text(
          extent={{-28,28},{42,-26}},
          lineColor={0,0,0},
          textString="Kp")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Proportional continuous time control block.<br>
  <pre>
   Y(s)      
   ----  = Kp
   U(s)      
  </pre>
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>y</FONT> ) saturates
  at the levels specified by <FONT FACE=Courier>Ymin</FONT> and <FONT FACE=Courier>Ymax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT>, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, is the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>y</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
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
end P;
