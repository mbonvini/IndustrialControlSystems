within IndustrialControlSystems.Logical.Counter;
model Counter "Model of an Up-Down counter"
  extends Interfaces.BaseCounter;
  discrete Integer Value( start=0);
  discrete Boolean CUd;
  discrete Boolean CDd;
  discrete Boolean Sd;
equation
  // assertions
  assert(PV>=0 and PV<=Max, "Preset Value out of range 0-999");
  assert(CV>=0 and CV<=Max, "Counter Value out of range");

  CV = Value;
  when sample(0,Ts) then
    CUd = CU;
    CDd = CD;
    Sd  = S;
    (Value,Q) = IndustrialControlSystems.Logical.Counter.Functions.count(
        pre(Value),
        PV,
        Sd,
        pre(Sd),
        CUd,
        pre(CUd),
        CDd,
        pre(CDd),
        R,
        Max);
  end when;

  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of an Up-Down counter.<br><br>
  
  At each time step <FONT FACE=Courier>Ts</FONT> the inputs are read and the new output values <FONT FACE=Courier>Q</FONT> and
  <FONT FACE=Courier>CV</FONT> are computed.<br><br>
  
  In the former image, are reported the <FONT FACE=Courier>S</FONT> (Set), <FONT FACE=Courier>R</FONT> (Reset), <FONT FACE=Courier>CU</FONT> (CountUP),
  <FONT FACE=Courier>CD</FONT> (CountDown) signals.<br>
  The latter images contains the <FONT FACE=Courier>CV</FONT> (Current Value) and the <FONT FACE=Courier>PV</FONT>(Preset Value).<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/Counter1.png\"><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/Counter2.png\">
  <br><br>
  
  The counter update the <FONT FACE=Courier>CV</FONT> when the Set signal rises, then for each rising edge of the Count Up (<FONT FACE=Courier>CU</FONT>) 
  or Count Down (<FONT FACE=Courier>CD</FONT>) signals the <FONT FACE=Courier>CV</FONT> is incremented or decremented by 1.<br>
  The Set signal has to be high during this phase, otherwise the rising edges are not detected.<br>
  When the Reset (<FONT FACE=Courier>R</FONT>) signal rises, the counter is reset to zero.<br>
  </p>
  <p>
  <b>Constraints</b><br>
  The current value <FONT FACE=Courier>CV</FONT> must be
  <pre> 
  0 &lt;= CV &lt;= Max
  </pre>
  Where <FONT FACE=Courier>Max</FONT> is the module of the counter.
  </p>
  
  </HTML>", revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &QUOT;Modelica/package.mo&QUOT;.</i><br/></dd>
</dl></html>"));
end Counter;
