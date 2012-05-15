within IndustrialControlSystems.MathOperations.IntegerType;
model Pow "Power of two integer numbers"
  extends
    IndustrialControlSystems.MathOperations.IntegerType.Interfaces.IntSimpleOperation;
protected
  Real u1R;
  Real u2R;
  Real yR;
equation
  assert(u1<>0 or u2>0,"division by zero");

  // conversion from Integer to Real
  u1R = u1;
  u2R = u2;
  // conversion from Real to Integer
  y = if (yR > 0) then integer(floor( yR + 0.5)) else
                       integer(ceil( yR - 0.5));

  if Ts > 0 then
    when sample(0,Ts) then
      yR = u1R^u2R;
    end when;
  else
     yR = u1R^u2R;
  end if;

  annotation (Icon(graphics={Text(
          extent={{-58,26},{68,-66}},
          lineColor={0,0,0},
          textString="**")}),Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of the power of two integers.<br>
  The output ( <FONT FACE=Courier>y</FONT> ) is the input ( <FONT FACE=Courier>u1</FONT> ) to the power of the second 
  input ( <FONT FACE=Courier>u2</FONT> ) signals.
  <pre>
    y = u1 ^ u2
  </pre>
  <br>
  The input <FONT FACE=Courier>u1</FONT> cannot be equal to zero if the second one,  <FONT FACE=Courier>u2</FONT>, is less than zero.
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
end Pow;
