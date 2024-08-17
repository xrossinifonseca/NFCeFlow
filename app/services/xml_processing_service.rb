

class XmlProcessingService


  def initialize(file,customer_id)
    @file = file
    @customer_id = customer_id
  end

  def process_and_save
    xml = parse_xml(@file)
    save_data(xml)
  end


  def parse_xml(file)
    xml = Nokogiri::XML(file)
    raise "Invalid XML file" unless xml.errors.empty?
    xml
  end


  def save_data(xml)

    nfe = xml.css("NFe")
    emit = nfe.css("emit").first
    dest = nfe.css("dest").first

    ActiveRecord::Base.transaction do
      issuer = Issuer.find_or_create_by(cnpj: emit.css("CNPJ").text) do |i|
        i.nome = emit.css("xNome").text
        i.nome_fantasia = emit.css("xFant").text
        i.logradouro = emit.css("xLgr").text
        i.numero = emit.css("nro").text
        i.municipio = emit.css("xMun").text
        i.codigo_municipio = emit.css("cMun").text
        i.bairro = emit.css("xBairro").text
        i.pais = emit.css("xPais").text
        i.uf = emit.css("UF").text
        i.cep = emit.css("CEP").text
        i.telefone = emit.css("fone").text
      end

      recipient = Recipient.find_or_create_by(cnpj: dest.css("CNPJ").text) do |r|
        r.nome = dest.css("xNome").text
        r.logradouro = dest.css("xLgr").text
        r.numero = dest.css("nro").text
        r.municipio = dest.css("xMun").text
        r.codigo_municipio = dest.css("cMun").text
        r.bairro = dest.css("xBairro").text
        r.pais = dest.css("xPais").text
        r.uf = dest.css("UF").text
        r.cep = dest.css("CEP").text
        r.telefone = dest.css("fone").text
      end

     nota = Nfce.create!(
        serie: nfe.css("serie").text,
        numero_nota: nfe.css("nNF").text,
        data_emissao: nfe.css("dhEmi").text,
        valor_total_desconto: nfe.css("total").css("vDesc").text,
        valor_total_produtos: nfe.css("total").css("vProd").text,
        valor_total: nfe.css("total").css("vBC").text,
        customer_id: @customer_id,
        recipient: recipient,
        issuer: issuer
      )

      taxa = Tax.create!(
        nfce:nota,
        valor_icms: nfe.css("total").css("vICMS").text,
        valor_total_ipi: nfe.css("total").css("vIPI").text,
        valor_total_cofins: nfe.css("total").css("vCOFINS").text,
        valor_tributo: nfe.css("total").css("vTotTrib").text
      )

      nfe.css("det").each do |det|
        product = Product.find_or_create_by(
          nome: det.css("xProd").text,
          ncm: det.css("NCM").text,
          cfop: det.css("CFOP").text,
        )

        NfceProduct.create!(
            product:product,
            nfce:nota,
            unidade_comercializada: det.css("uCom").text,
            quantidade_comercializada: det.css("qCom").text,
            valor_unitario: det.css("vUnCom").text,
            valor_icms: det.css("vICMS").text,
            valor_ipi: det.css("vIPI").text,
            valor_total: det.css("vProd").text,
          )
    end
    end
  end

end
