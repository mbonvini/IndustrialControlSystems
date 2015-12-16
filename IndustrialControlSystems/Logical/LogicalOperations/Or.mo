within IndustrialControlSystems.Logical.LogicalOperations;
model Or "Model of a n-bit OR"
  extends
    IndustrialControlSystems.Logical.LogicalOperations.Interfaces.LogicalBlock(
     nInput=2, final nOutput=1);
equation
  assert(nInput>=2,"nIinput must be higher than 2");

  if Ts > 0 then
    when sample(0,Ts) then
      y[1] = Functions.Or(u[:], nInput);
  end when;
  else
     y[1] = Functions.Or(u[:], nInput);
  end if;
  annotation (Icon(graphics={Text(
          extent={{-100,92},{100,60}},
          lineColor={0,0,0},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          textString="OR")}),
          Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a n bit OR gate.<br>
  The number of the input (<FONT FACE=Courier>nInput</FONT>) signals must be higher than 2, while the number of output 
  (<FONT FACE=Courier>nOutput</FONT>) signals is equal to 1.
  </p>
  <p>
  Depending on the value of the sampling time (<FONT FACE=Courier>Ts</FONT>), the model has two different behaviours:
  <ul>
  <li><pre>Ts &gt; 0</pre> it behaves as a discrete time system,</li>
  <li><pre>Ts &lt;= 0</pre> it behaves as a continous time system. No delay is introduced and events are generated when the output changes 
  (this mode reduces the simulation time)</li>
  </ul>
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
end Or;
