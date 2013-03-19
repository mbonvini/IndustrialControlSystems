within IndustrialControlSystems.MathOperations.RealType;
model Add "Sum of two real numbers"
  extends
    IndustrialControlSystems.MathOperations.RealType.Interfaces.RealSimpleOperation;
equation

  if FixedPoint then

    // Overflow : Numerical error
    assert(U1fp > MIN and U1fp < MAX, "Overflow error, chose a different scale factor or Nbit");
    assert(U2fp > MIN and U2fp < MAX, "Overflow error, chose a different scale factor or Nbit");

    // FixedPoint variables
    // conversion from Real to Integer
    U1fp = integer(Functions.toFixedPoint(u1,scaleFactor,MAX,MIN));
    U2fp = integer(Functions.toFixedPoint(u2,scaleFactor,MAX,MIN));

    // Math operation
    if Ts > 0 then
      when sample(0,Ts) then
        Yfp = max(MIN,min(MAX,U1fp + U2fp));
      end when;
    else
      Yfp = max(MIN,min(MAX,U1fp + U2fp));
    end if;

    // Output conversion
    y = Yfp/scaleFactor;

  else

    // FixedPoint variables
    U1fp = 0;
    U2fp = 0;
    Yfp = 0;

    // Math operation
    if Ts > 0 then
      when sample(0,Ts) then
        y = u1 + u2;
      end when;
    else
      y = u1 + u2;
    end if;

  end if;
  annotation (Icon(graphics={Text(
          extent={{-64,68},{72,-42}},
          lineColor={0,0,0},
          textString="+")}), Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Sum of two real numbers.
  The output ( <FONT FACE=Courier>y</FONT> ) is the sum of the inputs ( <FONT FACE=Courier>u1</FONT>, <FONT FACE=Courier>u2</FONT> ) signals.
  <pre>
    y = u1 + u2
  </pre>
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
  <FONT FACE=Courier>FixedPoint</FONT>), each input number <FONT FACE=Courier>u</FONT> is converted 
  into an integer <FONT FACE=Courier>Ufp</FONT>
  <br><pre>
  Ufp = u*scaleFactor
  </pre>
  then the result of the math operation <FONT FACE=Courier>Yfp</FONT> is computed and converted into the 
  output value <FONT FACE=Courier>y</FONT>. The output conversion depends on the math operation performed.
  </p>
  
  <h4>Saturation</h4>
  <p>
  To note that the Fixed Point numbers have a maximum and minimum value. In order to avoid saturation when<br>
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
end Add;
