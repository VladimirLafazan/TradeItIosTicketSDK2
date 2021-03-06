import UIKit

enum TicketRow {
    case account
    case orderAction
    case orderType
    case quantity
    case expiration
    case limitPrice
    case stopPrice
    case symbol
    case marketPrice
    case marginType
    case estimatedCost

    // FX
    case amount
    case bid
    case rate
    case leverage
    case priceType

    var cellReuseId: String {
        var cellReuseId: CellReuseId

        switch self {
        case .symbol, .orderAction, .leverage, .priceType, .orderType, .expiration, .marginType:
            cellReuseId = .selection
        case .estimatedCost:
            cellReuseId = .readOnly
        case .quantity, .limitPrice, .stopPrice, .amount:
            cellReuseId = .numericToggleInput
        case .marketPrice, .bid:
            cellReuseId = .marketData
        case .account:
            cellReuseId = .selectionDetail
        case .rate:
            cellReuseId = .stepperInput
        }

        return cellReuseId.rawValue
    }
        
    func getTitle(forOrder order: TradeItOrder) -> String {
        switch self {
        case .account: return order.linkedBrokerAccount?.brokerLongName ?? "Account"
        case .symbol: return "Symbol"
        case .marketPrice: return "Market price"
        case .orderAction: return "Action"
        case .quantity: return "Amount"
        case .orderType: return "Order type"
        case .limitPrice: return "Limit"
        case .stopPrice: return "Stop"
        case .expiration: return "Time in force"
        case .marginType: return "Type"
        case .estimatedCost: return "Estimated \(order.estimateLabel ?? "")"
        default: return "Unknown"
        }
    }

    static func registerNibCells(forTableView tableView: UITableView) {
        let bundle = TradeItBundleProvider.provide()
        tableView.register(
            UINib(nibName: "TradeItReadOnlyTableViewCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_READ_ONLY_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItSelectionCellTableViewCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_SELECTION_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItSelectionDetailCellTableViewCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_SELECTION_DETAIL_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItMarketDataTableViewCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_MARKET_DATA_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItNumericInputCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_NUMERIC_INPUT_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItNumericToggleInputTableViewCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_NUMERIC_TOGGLE_INPUT_CELL_ID"
        )
        tableView.register(
            UINib(nibName: "TradeItStepperInputCell", bundle: bundle),
            forCellReuseIdentifier: "TRADING_TICKET_STEPPER_INPUT_CELL_ID"
        )
    }
}
