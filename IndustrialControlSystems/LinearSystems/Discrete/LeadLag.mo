within IndustrialControlSystems.LinearSystems.Discrete;
model LeadLag "Lead lag process: mu(1+T1*s)/(1+T2*s)"
  extends Interfaces.DiscreteBaseBlock;
  parameter Real mu = 1 "|Block parameters| Gain";
  parameter Real T1 = 0.001 "|Block parameters| Costante di tempo dello zero";
  parameter Real T2 = 0.25 "|Block parameters| Costante di tempo del polo";
  parameter Real y_start = 0 "|Initial conditions| Output initial value";
initial equation
  pre(y) = y_start;
equation
  assert(abs(T1-T2)>1e-8,"T1 must be != T2");

  when sample(0,Ts) then
    y = Functions.f1p1z(alfa,T1,T2,u,pre(u),pre(y),Ts,mu);
  end when;
  annotation (Icon(graphics={
        Text(
          extent={{-42,30},{60,8}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*T1"),
        Line(
          points={{-40,0},{54,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-42,-14},{60,-36}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="1+s*T2")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discretised version of the continuous time transfer function of a lead lag process.
  <pre>
   Y(s)        (1 + s*T1)
   ----  = mu ------------
   U(s)        (1 + s*T2)
  </pre>
  <br>
  The time constant <FONT FACE=Courier>T1</FONT> must be different from <FONT FACE=Courier>T2</FONT>.
  </p>
  <p>
  <h4>Discretisation</h4>
  The discretisation of the continuos time transfer function has been performed with the bilinear transformation formula
  <pre>
                 z - 1 
  s = ------------------------------
        z*alpha*Ts - (alpha - 1)*Ts
  </pre>
  that is equivalent to<br>
  <ul>
  <li>Forward Euler (FE) if <pre><FONT FACE=Courier>alpha = 0</FONT></pre></li>
  <li>Backward Euler (BE) if <pre><FONT FACE=Courier>alpha = 1</FONT></pre></li>
  <li>Tustin (TU) if <pre><FONT FACE=Courier>alpha = 0.5</FONT></pre></li>
  </ul>
  </p>
  </HTML>", revisions="<html>
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
end LeadLag;
