within IndustrialControlSystems.Logical.LogicalOperations;
model FlipFlopSR "Model of a Set-reset Flip Flop"
  extends Interfaces.LogicalBlock2x2;
  parameter Boolean q_start = false "Output initial value";
initial equation
  y1 = q_start;
  y2 = not q_start;
equation

  when sample(0,Ts) then
      y1 = Functions.SR(u1,u2,pre(y1));
      y2 = not y1;
  end when;

  annotation (Diagram(graphics), Icon(graphics={
        Text(
          extent={{-100,94},{98,72}},
          lineColor={0,0,0},
          textString="FF SR"),
        Text(
          extent={{-60,58},{-28,36}},
          lineColor={0,0,0},
          textString="S"),
        Text(
          extent={{-60,-40},{-28,-62}},
          lineColor={0,0,0},
          textString="R"),
        Text(
          extent={{48,56},{80,34}},
          lineColor={0,0,0},
          textString="Q")}),
          Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a Set Reset Flip Flop.<br><br>
  The inputs and outputs follows
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH></TR>
  <tr>  <td>u1</td><td>Set</td>  </tr>
  <tr>  <td>u2</td><td>Reset</td>  </tr>
  <tr>  <td>y1</td><td>Q</td>  </tr>
  <tr>  <td>y2</td><td>not Q</td>  </tr>
  </table>
  </p>
  
  <p>
  Behaviour of the FlipFlop, at each time step <FONT FACE=Courier>Ts</FONT> the inputs are read and the new output <FONT FACE=Courier>Q</FONT> <br>
  is computed starting from the <FONT FACE=Courier>S</FONT> and <FONT FACE=Courier>R</FONT> value as well the old value of the output 
  <FONT FACE=Courier>Q<sup>OLD</sup></FONT>.
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Set</TH><TH >Reset</TH><TH>Q</TH></TR>
  <tr>  <td>0</td><td>0</td><td>Q<sup>OLD</sup></td>  </tr>
  <tr>  <td>0</td><td>1</td><td>0</td>  </tr>
  <tr>  <td>1</td><td>0</td><td>1</td>  </tr>
  <tr>  <td>1</td><td>1</td><td> not Q<sup>OLD</sup></td>  </tr>
  </table><br>
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
end FlipFlopSR;
