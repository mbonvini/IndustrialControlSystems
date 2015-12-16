within IndustrialControlSystems.MathOperations.RealType;
model Expression "User defined real function"
  extends
    IndustrialControlSystems.MathOperations.RealType.Interfaces.RealNinOperation;
  replaceable function f =
      IndustrialControlSystems.MathOperations.RealType.Functions.GeneralFunction
    "generic real function" annotation (Documentation(revisions="<html>
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
  parameter String fname = "F name"
    "String that represent the name of the implemented function";
  replaceable function g =
      IndustrialControlSystems.MathOperations.RealType.Functions.GeneralReScalingFunction
    "|Fixed Point| Output re-scaling function" annotation (Documentation(
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
equation

  if FixedPoint then

    // Overflow : Numerical error
    for i in 1:nInput loop
      assert(Ufp[i] > MIN and Ufp[i] < MAX, "Overflow error, chose a different scale factor or Nbit");
    end for;

    // FixedPoint variables
    // conversion from Real to Integer
    for i in 1:nInput loop
      Ufp[i] = integer(Functions.toFixedPoint(u[i],scaleFactor,MAX,MIN));
    end for;

    // Math operation
    if Ts > 0 then
      when sample(0,Ts) then
        Yfp = max(MIN,min(MAX,integer(f(Ufp[:]))));
      end when;
    else
       Yfp = max(MIN,min(MAX,integer(f(Ufp[:]))));
    end if;

    // Output conversion
    y = g(Ufp[:],Yfp,scaleFactor);

  else

    // FixedPoint variables
    Ufp = zeros(nInput);
    Yfp = 0;

    // Math operation
    if Ts > 0 then
      when sample(0,Ts) then
        y = f(u[:]);
      end when;
    else
       y = f(u[:]);
    end if;

  end if;

  annotation (Diagram(graphics), Icon(graphics={Text(
          extent={{-100,86},{100,60}},
          lineColor={0,0,0},
          textString="%fname")}), Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a generic function of n real numbers.<br>
  The output ( <FONT FACE=Courier>y</FONT> ) is the result of the generic function <FONT FACE=Courier>f(.)</FONT> of the 
  inputs ( <FONT FACE=Courier>u(:)</FONT> ) signals.
  <pre>
    y = f(u[:])
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
end Expression;
