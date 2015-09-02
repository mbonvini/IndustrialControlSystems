within IndustrialControlSystems.MathOperations.RealType.Interfaces;
partial model RealNinOperation "Real comparison interface"
  parameter Real Ts = 0.1 "sampling time" annotation(Evaluate=true);
  parameter Integer nInput = 1 "number of inputs" annotation(Evaluate=true);
  parameter Boolean useInputs = true "=true, if inputs are enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean FixedPoint = false
    "|Fixed Point| Use fixed point real numbers"  annotation(Evaluate=true);
  parameter Integer Nbit=16 " Number of bit for representing the real numbers"
    annotation (Dialog(group="Fixed Point", enable=FixedPoint));
  parameter Real scaleFactor = 1
    "|Fixed Point| Scale factor for Fixed Point numbers";
  Integer Ufp[nInput] "floating point converted input";
  Integer Yfp "floating point converted output";
  Modelica.Blocks.Interfaces.RealInput u[nInput] if useInputs "input vector"
                                                              annotation (Placement(
        transformation(
        origin={-80,0},
        extent={{-20,-20},{20,20}},
        rotation=0), iconTransformation(extent={{-100,-20},{-60,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0), iconTransformation(extent={{80,-10},{100,10}})));
  parameter Integer MAX = integer(2^(Nbit-1))
    "|Fixed Point| maximum number that can be represented with Fixed Point notation"
                                                                                     annotation(Evaluate=true);
  parameter Integer MIN = -integer(2^(Nbit-1)) + 1
    "|Fixed Point| mainimum number that can be represented with Fixed Point notation"
                                                                                                        annotation(Evaluate=true);

  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Real math operations.
  </p>
  <h4>Fixed Point numbers</h4>
  <p>
  When using fixed point real numbers, <FONT FACE=Courier>Nbit</FONT> is the number of bits that 
  can be represented. The range is
  <pre>
  Xfp in [-2<sup>Nbit - 1</sup> + 1  ,...,  2<sup>Nbit - 1</sup>]
  </pre>
  Then it is possible to define a <FONT FACE=Courier>scaleFactor</FONT>
  <br><pre>
  X = Xfp/scaleFactor
  </pre>
  When the Fixed Point representation is selected (through the selection of the boolean flag 
  <FONT FACE=Courier>FixedPoint</FONT>), each input number <FONT FACE=Courier>u[:]</FONT> is converted 
  into an integer <FONT FACE=Courier>Ufp[:]</FONT>
  <br><pre>
  Ufp[:] = u[:]*scaleFactor
  </pre>
  then the result of the math operation <FONT FACE=Courier>Yfp</FONT> is computed and converted into the 
  output value <FONT FACE=Courier>y</FONT>. The output conversion depends on the math operation performed.
  </p>
  
  <h4>Saturation</h4>
  <p>
  To note that the Fixed Point numbers have a maximum and minimum value. In order to avoid saturation when 
  performing the computations, the number of bit as well the scale factor have to be choosen carefully. 
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
end RealNinOperation;
